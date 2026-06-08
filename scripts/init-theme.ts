#!/usr/bin/env bun
// Bootstrap a new theme from this template:
//   - rename the nvim module dir  lua/<old>/  -> lua/<slug>/
//   - rename the nvim entry       colors/<old>.lua -> colors/<slug>.lua
//   - rewrite require("<old>…") and colors_name in lua files
//   - set palette.json "name"
import fs from "node:fs";
import path from "node:path";

const ROOT = path.resolve(import.meta.dir, "..");
const displayName = process.argv[2];
if (!displayName) {
  console.error("Usage: bun run init-theme <Name>   (e.g. bun run init-theme Rime)");
  process.exit(1);
}
const slug = displayName.toLowerCase().replace(/[^a-z0-9]+/g, "-").replace(/^-+|-+$/g, "");

// 1. discover current slug from the single colors/*.lua entry
const colorsDir = path.join(ROOT, "colors");
const entries = fs.readdirSync(colorsDir).filter((f) => f.endsWith(".lua"));
if (entries.length !== 1) {
  console.error(`Expected exactly one colors/*.lua, found ${entries.length}`);
  process.exit(1);
}
const oldSlug = entries[0].replace(/\.lua$/, "");

if (oldSlug !== slug) {
  // 2. rename lua module dir
  const oldLua = path.join(ROOT, "lua", oldSlug);
  const newLua = path.join(ROOT, "lua", slug);
  if (fs.existsSync(oldLua)) fs.renameSync(oldLua, newLua);
  // 3. rename colors entry
  fs.renameSync(path.join(colorsDir, `${oldSlug}.lua`), path.join(colorsDir, `${slug}.lua`));
  // 4. rewrite require() module paths + colors_name across lua files
  const luaFiles: string[] = [];
  const walk = (d: string) => {
    for (const e of fs.readdirSync(d, { withFileTypes: true })) {
      const p = path.join(d, e.name);
      if (e.isDirectory()) walk(p);
      else if (e.name.endsWith(".lua")) luaFiles.push(p);
    }
  };
  walk(path.join(ROOT, "lua", slug));
  luaFiles.push(path.join(colorsDir, `${slug}.lua`));
  for (const f of luaFiles) {
    let s = fs.readFileSync(f, "utf8");
    s = s.split(`"${oldSlug}.`).join(`"${slug}.`); // require("lume.theme")
    s = s.split(`"${oldSlug}"`).join(`"${slug}"`); // require("lume"), colors_name = "lume"
    s = s.split(`[${oldSlug}]`).join(`[${slug}]`); // vim.notify("[lume] …") log prefix
    fs.writeFileSync(f, s);
  }
}

// 5. set palette name
const palPath = path.join(ROOT, "palette.json");
const pal = JSON.parse(fs.readFileSync(palPath, "utf8"));
pal.name = displayName;
fs.writeFileSync(palPath, `${JSON.stringify(pal, null, 2)}\n`);

console.log(`Initialized theme "${displayName}" (slug: ${slug}).`);
console.log("Next: edit palette.json colors, then run `bun run generate`.");
