import { describe, it, expect } from "bun:test";
import { relativeLuminance, contrastRatio, validatePalette } from "../scripts/validate-contrast";
import palette from "../palette.json";

describe("relativeLuminance", () => {
  it("returns 0 for black", () => {
    expect(relativeLuminance("#000000")).toBe(0);
  });

  it("returns 1 for white", () => {
    expect(relativeLuminance("#ffffff")).toBe(1);
  });

  it("computes mid-gray correctly", () => {
    const lum = relativeLuminance("#808080");
    expect(lum).toBeGreaterThan(0.2);
    expect(lum).toBeLessThan(0.25);
  });

  it("throws on invalid hex", () => {
    expect(() => relativeLuminance("not-a-color")).toThrow("Invalid hex color");
    expect(() => relativeLuminance("#fff")).toThrow("Invalid hex color");
    expect(() => relativeLuminance("")).toThrow("Invalid hex color");
  });
});

describe("contrastRatio", () => {
  it("black on white is 21:1", () => {
    expect(contrastRatio("#000000", "#ffffff")).toBe(21);
  });

  it("same color is 1:1", () => {
    expect(contrastRatio("#1a1724", "#1a1724")).toBe(1);
  });

  it("is symmetric", () => {
    const a = contrastRatio("#d8d0e4", "#1a1724");
    const b = contrastRatio("#1a1724", "#d8d0e4");
    expect(a).toBe(b);
  });
});

describe("validatePalette", () => {
  it("passes for the Lume palette", () => {
    const results = validatePalette(palette);
    expect(results.pass).toBe(true);
    if (!results.pass) {
      console.log("Failures:", JSON.stringify(results.failures, null, 2));
    }
  });

  it("fails when text has no contrast", () => {
    const badPalette = {
      name: "bad",
      variant: "dark",
      backgrounds: { base: "#1a1724", surface0: "#211e2e", surface1: "#2a2738" },
      foregrounds: { text: "#1a1724", subtext: "#1a1724" },
      accents: {},
      ansi: {},
      special: {},
    };
    const results = validatePalette(badPalette as any);
    expect(results.pass).toBe(false);
    expect(results.failures.length).toBeGreaterThan(0);
  });

  it("fails when comment has insufficient contrast", () => {
    const badPalette = {
      name: "bad",
      variant: "dark",
      backgrounds: { base: "#1a1724" },
      foregrounds: { text: "#d8d0e4", comment: "#1e1b2a" },
      accents: {},
      ansi: {},
      special: {},
    };
    const results = validatePalette(badPalette as any);
    expect(results.pass).toBe(false);
    expect(results.failures.some(f => f.name.includes("comment"))).toBe(true);
  });

  it("throws on missing required palette groups", () => {
    expect(() => validatePalette({} as any)).toThrow("Palette missing required group");
  });

  it("fails when ansi black has insufficient contrast against base", () => {
    const badPalette = {
      name: "bad",
      variant: "dark",
      backgrounds: { base: "#12101e" },
      foregrounds: { text: "#d8d0e4" },
      accents: {},
      ansi: { black: "#12101e" },
      special: {},
    };
    const results = validatePalette(badPalette as any);
    expect(results.pass).toBe(false);
    expect(results.failures.some(f => f.name.includes("ansi black"))).toBe(true);
  });

  it("fails when ansi brightBlack has insufficient contrast against base", () => {
    const badPalette = {
      name: "bad",
      variant: "dark",
      backgrounds: { base: "#12101e" },
      foregrounds: { text: "#d8d0e4" },
      accents: {},
      ansi: { brightBlack: "#1e1a2c" },
      special: {},
    };
    const results = validatePalette(badPalette as any);
    expect(results.pass).toBe(false);
    expect(results.failures.some(f => f.name.includes("ansi brightBlack"))).toBe(true);
  });
});
