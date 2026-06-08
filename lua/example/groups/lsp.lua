local M = {}

function M.get(p, config)
  local fg = p.foregrounds
  local bg = p.backgrounds
  local ac = p.accents
  local util = require("example.util")

  local italic = config.italics

  return {
    -- ── Diagnostics — base ───────────────────────────────────────────────
    DiagnosticError = { fg = ac.error },
    DiagnosticWarn = { fg = ac.number },
    DiagnosticInfo = { fg = ac.func },
    DiagnosticHint = { fg = ac.tag },
    DiagnosticOk = { fg = ac.string },

    -- ── Diagnostics — virtual text (alpha blended onto base) ────────────
    DiagnosticVirtualTextError = { fg = ac.error, bg = util.blend(ac.error, bg.base, 0.08) },
    DiagnosticVirtualTextWarn = { fg = ac.number, bg = util.blend(ac.number, bg.base, 0.08) },
    DiagnosticVirtualTextInfo = { fg = ac.func, bg = util.blend(ac.func, bg.base, 0.08) },
    DiagnosticVirtualTextHint = { fg = ac.tag, bg = util.blend(ac.tag, bg.base, 0.08) },
    DiagnosticVirtualTextOk = { fg = ac.string, bg = util.blend(ac.string, bg.base, 0.08) },

    -- ── Diagnostics — underline ──────────────────────────────────────────
    DiagnosticUnderlineError = { undercurl = true, sp = ac.error },
    DiagnosticUnderlineWarn = { undercurl = true, sp = ac.number },
    DiagnosticUnderlineInfo = { undercurl = true, sp = ac.func },
    DiagnosticUnderlineHint = { undercurl = true, sp = ac.tag },
    DiagnosticUnderlineOk = { undercurl = true, sp = ac.string },

    -- ── Diagnostics — sign column ────────────────────────────────────────
    DiagnosticSignError = { fg = ac.error },
    DiagnosticSignWarn = { fg = ac.number },
    DiagnosticSignInfo = { fg = ac.func },
    DiagnosticSignHint = { fg = ac.tag },
    DiagnosticSignOk = { fg = ac.string },

    -- ── Diagnostics — floating window ────────────────────────────────────
    DiagnosticFloatingError = { fg = ac.error },
    DiagnosticFloatingWarn = { fg = ac.number },
    DiagnosticFloatingInfo = { fg = ac.func },
    DiagnosticFloatingHint = { fg = ac.tag },
    DiagnosticFloatingOk = { fg = ac.string },

    -- ── LSP references ───────────────────────────────────────────────────
    LspReferenceText = { bg = bg.surface1 },
    LspReferenceRead = { bg = bg.surface1 },
    LspReferenceWrite = { bg = bg.surface1, bold = true },

    -- ── LSP misc ─────────────────────────────────────────────────────────
    LspSignatureActiveParameter = { fg = ac.type, bold = true },
    LspCodeLens = { fg = fg.overlay },
    LspCodeLensSeparator = { fg = fg.overlay },
    LspInlayHint = { fg = fg.overlay, bg = bg.surface0, italic = true },
    LspInfoBorder = { fg = bg.surface2, bg = bg.surface0 },

    -- ── LSP semantic tokens — types ──────────────────────────────────────
    ["@lsp.type.class"] = { fg = ac.type },
    ["@lsp.type.enum"] = { fg = ac.type },
    ["@lsp.type.enumMember"] = { fg = ac.type },
    ["@lsp.type.struct"] = { fg = ac.type },
    ["@lsp.type.interface"] = { fg = ac.type, italic = italic },
    ["@lsp.type.typeParameter"] = { fg = ac.type, italic = italic },
    ["@lsp.type.type"] = { fg = ac.type },
    ["@lsp.type.namespace"] = { fg = fg.text },

    -- ── LSP semantic tokens — functions ─────────────────────────────────
    ["@lsp.type.function"] = { fg = ac.func },
    ["@lsp.type.method"] = { fg = ac.func },

    -- ── LSP semantic tokens — variables / parameters ─────────────────────
    ["@lsp.type.variable"] = { fg = fg.text },
    ["@lsp.type.parameter"] = { fg = fg.text },
    ["@lsp.type.property"] = { fg = fg.text },

    -- ── LSP semantic tokens — keywords ───────────────────────────────────
    ["@lsp.type.keyword"] = { fg = ac.keyword },
    ["@lsp.type.modifier"] = { fg = ac.keyword },
    ["@lsp.type.decorator"] = { fg = ac.type },

    -- ── LSP semantic tokens — modifiers ──────────────────────────────────
    ["@lsp.typemod.function.defaultLibrary"] = { fg = ac.func, italic = italic },
    ["@lsp.typemod.method.defaultLibrary"] = { fg = ac.func, italic = italic },
    ["@lsp.typemod.variable.defaultLibrary"] = { fg = fg.text, italic = italic },
    ["@lsp.typemod.variable.readonly"] = { fg = fg.text },
    ["@lsp.typemod.variable.static"] = { fg = fg.text },
    ["@lsp.typemod.property.readonly"] = { fg = fg.text, italic = italic },
    ["@lsp.typemod.class.defaultLibrary"] = { fg = ac.type },
    ["@lsp.typemod.type.defaultLibrary"] = { fg = ac.type, italic = italic },
  }
end

return M
