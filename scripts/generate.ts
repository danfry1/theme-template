import fs from "node:fs";
import path from "node:path";
import Mustache from "mustache";
import { validatePalette, type Palette } from "./validate-contrast";

const ROOT = path.resolve(import.meta.dir, "..");

export function flattenPalette(obj: Record<string, unknown>, prefix?: string): Record<string, string> {
  const result: Record<string, string> = {};
  for (const [key, value] of Object.entries(obj)) {
    const fullKey = prefix ? `${prefix}.${key}` : key;
    if (typeof value === "object" && value !== null) {
      Object.assign(result, flattenPalette(value as Record<string, unknown>, fullKey));
    } else {
      result[fullKey] = String(value);
    }
  }
  return result;
}

function hexToComponents(hex: string): { r: number; g: number; b: number } {
  if (typeof hex !== "string" || !/^#[0-9a-fA-F]{6}$/.test(hex)) {
    throw new Error(`Invalid hex color: ${JSON.stringify(hex)}`);
  }
  const h = hex.slice(1);
  return {
    r: parseInt(h.slice(0, 2), 16),
    g: parseInt(h.slice(2, 4), 16),
    b: parseInt(h.slice(4, 6), 16),
  };
}

export function renderTemplate(template: string, palette: Palette): string {
  // Build a deep copy of the palette as the Mustache view
  // Mustache resolves {{backgrounds.base}} by traversing the nested object
  const view: Record<string, unknown> = JSON.parse(JSON.stringify(palette));
  view.slug = slugify(palette.name);
  const flat = flattenPalette(palette as unknown as Record<string, unknown>);

  // Add helper variants for hex colors
  for (const [key, value] of Object.entries(flat)) {
    if (typeof value === "string" && /^#[0-9a-fA-F]{6}$/.test(value)) {
      const { r, g, b } = hexToComponents(value);
      const safeKey = key.replace(/\./g, "_");
      view[`${safeKey}_hex`] = value.slice(1);
      view[`${safeKey}_rgb`] = `${r},${g},${b}`;
      view[`${safeKey}_r`] = (r / 255).toFixed(6);
      view[`${safeKey}_g`] = (g / 255).toFixed(6);
      view[`${safeKey}_b`] = (b / 255).toFixed(6);
    }
  }

  const rendered = Mustache.render(template, view);

  // Validate no empty color values in output
  if (rendered.trim().length === 0) {
    throw new Error("Template rendered to empty output");
  }

  return rendered;
}

export function generatePaletteLua(palette: Palette): string {
  const lines: string[] = [
    "-- Auto-generated from palette.json — do not edit manually",
    "-- Run `bun run generate` to regenerate",
    "",
    "local M = {}",
    "",
  ];

  const sections: [string, Record<string, string>][] = [
    ["backgrounds", palette.backgrounds],
    ["foregrounds", palette.foregrounds],
    ["accents", palette.accents],
    ["ansi", palette.ansi],
    ["special", palette.special],
  ];

  for (const [name, obj] of sections) {
    lines.push(`M.${name} = {`);
    for (const [key, value] of Object.entries(obj)) {
      // Escape any special characters in the value for Lua string safety
      const escaped = String(value).replace(/\\/g, "\\\\").replace(/"/g, '\\"');
      lines.push(`  ${key} = "${escaped}",`);
    }
    lines.push("}");
    lines.push("");
  }

  lines.push("return M");
  lines.push("");
  return lines.join("\n");
}

function buildTargets(slug: string) {
  return [
    { template: "kitty.mustache", output: `terminals/kitty/${slug}.conf` },
    { template: "alacritty.mustache", output: `terminals/alacritty/${slug}.toml` },
    { template: "wezterm.mustache", output: `terminals/wezterm/${slug}.toml` },
    { template: "iterm2.mustache", output: `terminals/iterm2/${slug}.itermcolors` },
    { template: "ghostty.mustache", output: `terminals/ghostty/${slug}` },
    { template: "foot.mustache", output: `terminals/foot/${slug}.ini` },
    { template: "windows-terminal.mustache", output: `terminals/windows-terminal/${slug}.json` },
    { template: "fzf.mustache", output: `cli/fzf/${slug}.sh` },
    { template: "bat.mustache", output: `cli/bat/${slug}.tmTheme` },
    { template: "delta.mustache", output: `cli/delta/${slug}.gitconfig` },
    { template: "lazygit.mustache", output: `cli/lazygit/${slug}.yml` },
    { template: "tmux.mustache", output: `tmux/${slug}-theme.conf` },
    { template: "vscode.mustache", output: `editors/vscode/themes/${slug}-color-theme.json` },
    { template: "zed.mustache", output: `editors/zed/themes/${slug}.json` },
    { template: "opencode.mustache", output: `cli/opencode/${slug}.json` },
  ];
}

function slugify(name: string): string {
  return name.toLowerCase().replace(/[^a-z0-9]+/g, "-").replace(/^-+|-+$/g, "");
}

interface GenerateOptions {
  validateOnly?: boolean;
  check?: boolean;
}

export function generate(opts: GenerateOptions = {}): void {
  let palette: Palette;
  try {
    const raw = fs.readFileSync(path.join(ROOT, "palette.json"), "utf8");
    palette = JSON.parse(raw);
  } catch (err) {
    console.error(`Failed to read palette.json: ${(err as Error).message}`);
    process.exit(1);
  }

  // Validate contrast
  const validation = validatePalette(palette);
  if (!validation.pass) {
    console.error("WCAG AA contrast validation failed:");
    for (const f of validation.failures) {
      console.error(`  ${f.name}: ${f.ratio}:1 (required ${f.required}:1)`);
    }
    process.exit(1);
  }
  console.log("Contrast validation passed.");

  if (opts.validateOnly) return;

  const slug = slugify(palette.name);
  const targets = buildTargets(slug);

  // Generate palette.lua
  const luaPath = path.join(ROOT, `lua/${slug}/palette.lua`);
  const newLua = generatePaletteLua(palette);

  if (opts.check) {
    // Drift detection mode: compare all generated files without writing
    const stale: string[] = [];

    function checkFile(filePath: string, expected: string, label: string) {
      if (!fs.existsSync(filePath)) {
        stale.push(`${label} does not exist`);
      } else if (fs.readFileSync(filePath, "utf8") !== expected) {
        stale.push(`${label} is out of date`);
      }
    }

    checkFile(luaPath, newLua, `lua/${slug}/palette.lua`);

    for (const target of targets) {
      const templatePath = path.join(ROOT, "templates", target.template);
      if (!fs.existsSync(templatePath)) {
        stale.push(`Template not found: templates/${target.template}`);
        continue;
      }
      const template = fs.readFileSync(templatePath, "utf8");
      const expected = renderTemplate(template, palette);
      checkFile(path.join(ROOT, target.output), expected, target.output);
    }

    if (stale.length > 0) {
      console.error("Generated files are out of date. Run `bun run generate` to update:");
      for (const msg of stale) {
        console.error(`  ${msg}`);
      }
      process.exit(1);
    }

    console.log("Drift check passed.");
    return;
  }

  fs.mkdirSync(path.dirname(luaPath), { recursive: true });
  fs.writeFileSync(luaPath, newLua);
  console.log(`Generated: lua/${slug}/palette.lua`);

  // Render templates
  for (const target of targets) {
    const templatePath = path.join(ROOT, "templates", target.template);
    if (!fs.existsSync(templatePath)) {
      console.error(`ERROR: Template not found: templates/${target.template}`);
      process.exit(1);
    }
    const template = fs.readFileSync(templatePath, "utf8");
    const rendered = renderTemplate(template, palette);
    const outputPath = path.join(ROOT, target.output);
    fs.mkdirSync(path.dirname(outputPath), { recursive: true });
    fs.writeFileSync(outputPath, rendered);
    console.log(`Generated: ${target.output}`);
  }
}

// CLI entry point
if (import.meta.main) {
  const validateOnly = process.argv.includes("--validate-only");
  const check = process.argv.includes("--check");
  generate({ validateOnly, check });
}
