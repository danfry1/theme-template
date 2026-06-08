import { describe, it, expect } from "bun:test";
import { flattenPalette, renderTemplate, generatePaletteLua } from "../scripts/generate";
import palette from "../palette.json";

describe("flattenPalette", () => {
  it("flattens nested palette into dot-notation keys", () => {
    const flat = flattenPalette(palette);
    expect(flat["backgrounds.base"]).toBe(palette.backgrounds.base);
    expect(flat["accents.keyword"]).toBe(palette.accents.keyword);
    expect(flat["ansi.brightWhite"]).toBe(palette.ansi.brightWhite);
    expect(flat["special.cursor"]).toBe(palette.special.cursor);
    expect(flat["name"]).toBe(palette.name); // palette-driven, not hardcoded
  });
});

describe("renderTemplate", () => {
  it("renders template with palette values", () => {
    const template = "foreground {{foregrounds.text}}\nbackground {{backgrounds.base}}";
    const result = renderTemplate(template, palette as any);
    expect(result).toContain(`foreground ${palette.foregrounds.text}`);
    expect(result).toContain(`background ${palette.backgrounds.base}`);
  });

  it("renders _hex helper variants correctly", () => {
    const expectedHex = palette.backgrounds.base.slice(1);
    const template = "bg={{backgrounds_base_hex}}";
    const result = renderTemplate(template, palette as any);
    expect(result).toBe(`bg=${expectedHex}`);
  });

  it("renders _r/_g/_b float helpers correctly", () => {
    const template = "r={{backgrounds_base_r}} g={{backgrounds_base_g}} b={{backgrounds_base_b}}";
    const result = renderTemplate(template, palette as any);
    expect(result).toMatch(/r=0\.\d+ g=0\.\d+ b=0\.\d+/);
    expect(result).not.toContain("NaN");
    expect(result).not.toContain("undefined");
  });

  it("throws on empty rendered output", () => {
    expect(() => renderTemplate("", palette as any)).toThrow("empty output");
  });
});

describe("generatePaletteLua", () => {
  it("generates valid Lua table from palette", () => {
    const lua = generatePaletteLua(palette as any);
    expect(lua).toContain(`base = "${palette.backgrounds.base}"`);
    expect(lua).toContain(`keyword = "${palette.accents.keyword}"`);
    expect(lua).toContain("return M");
  });

  it("includes all palette sections", () => {
    const lua = generatePaletteLua(palette as any);
    expect(lua).toContain("M.backgrounds");
    expect(lua).toContain("M.foregrounds");
    expect(lua).toContain("M.accents");
    expect(lua).toContain("M.ansi");
    expect(lua).toContain("M.special");
  });
});
