export interface PaletteGroup {
  [key: string]: string;
}

export interface Palette {
  name: string;
  variant: string;
  backgrounds: PaletteGroup;
  foregrounds: PaletteGroup;
  accents: PaletteGroup;
  ansi: PaletteGroup;
  special: PaletteGroup;
}

export interface ContrastFailure {
  name: string;
  fg: string;
  bg: string;
  ratio: number;
  required: number;
}

export interface ValidationResult {
  pass: boolean;
  failures: ContrastFailure[];
}

function parseHex(hex: string): [number, number, number] {
  if (typeof hex !== "string" || !/^#[0-9a-fA-F]{6}$/.test(hex)) {
    throw new Error(`Invalid hex color: ${JSON.stringify(hex)}`);
  }
  const h = hex.slice(1);
  return [
    parseInt(h.slice(0, 2), 16) / 255,
    parseInt(h.slice(2, 4), 16) / 255,
    parseInt(h.slice(4, 6), 16) / 255,
  ];
}

function linearize(c: number): number {
  return c <= 0.04045 ? c / 12.92 : Math.pow((c + 0.055) / 1.055, 2.4);
}

export function relativeLuminance(hex: string): number {
  const [r, g, b] = parseHex(hex).map(linearize);
  return 0.2126 * r + 0.7152 * g + 0.0722 * b;
}

export function contrastRatio(hex1: string, hex2: string): number {
  const l1 = relativeLuminance(hex1);
  const l2 = relativeLuminance(hex2);
  const lighter = Math.max(l1, l2);
  const darker = Math.min(l1, l2);
  return Math.round(((lighter + 0.05) / (darker + 0.05)) * 100) / 100;
}

export function validatePalette(palette: Palette): ValidationResult {
  const failures: ContrastFailure[] = [];

  // Structural validation
  const requiredGroups = ["backgrounds", "foregrounds"] as const;
  for (const group of requiredGroups) {
    if (!palette[group] || typeof palette[group] !== "object") {
      throw new Error(`Palette missing required group: "${group}"`);
    }
  }
  if (!palette.backgrounds.base) throw new Error('Palette missing backgrounds.base');
  if (!palette.foregrounds.text) throw new Error('Palette missing foregrounds.text');

  const bg = palette.backgrounds;
  const fg = palette.foregrounds;
  const surfaces = [bg.base, bg.surface0, bg.surface1].filter(Boolean);

  function check(name: string, fgHex: string, bgHex: string, minRatio: number) {
    const ratio = contrastRatio(fgHex, bgHex);
    if (ratio < minRatio) {
      failures.push({ name, fg: fgHex, bg: bgHex, ratio, required: minRatio });
    }
  }

  // Body text: 4.5:1 against all surfaces
  for (const surface of surfaces) {
    if (fg.text) check(`text on ${surface}`, fg.text, surface, 4.5);
    if (fg.subtext) check(`subtext on ${surface}`, fg.subtext, surface, 4.5);
  }

  // Overlay (UI element): 3:1 against base through surface1
  for (const surface of surfaces) {
    if (fg.overlay) check(`overlay on ${surface}`, fg.overlay, surface, 3);
  }

  // Comment: 3:1 against base only (intentionally subdued)
  if (fg.comment) check("comment on base", fg.comment, bg.base, 3);

  // Accents used as syntax highlighting (body text): 4.5:1 against base
  // Also 3:1 against surfaces where they appear (cursorline, popups)
  for (const [name, hex] of Object.entries(palette.accents || {})) {
    check(`${name} on base`, hex, bg.base, 4.5);
    if (bg.surface0) check(`${name} on surface0`, hex, bg.surface0, 3);
  }

  // ANSI black/brightBlack: must be readable as foreground on base
  const ansi = palette.ansi || {};
  if (ansi.black) check("ansi black on base", ansi.black, bg.base, 2);
  if (ansi.brightBlack) check("ansi brightBlack on base", ansi.brightBlack, bg.base, 3);

  return { pass: failures.length === 0, failures };
}
