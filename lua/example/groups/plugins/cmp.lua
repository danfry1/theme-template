local M = {}

function M.get(p, config)
  local fg = p.foregrounds
  local bg = p.backgrounds
  local ac = p.accents

  return {
    CmpItemAbbr = { fg = fg.subtext },
    CmpItemAbbrDeprecated = { fg = fg.overlay, strikethrough = true },
    CmpItemAbbrMatch = { fg = ac.type, bold = true },
    CmpItemAbbrMatchFuzzy = { fg = ac.type, bold = true },
    CmpItemMenu = { fg = fg.overlay },
    CmpItemKind = { fg = ac.keyword },

    -- Kind icons / labels
    CmpItemKindClass = { fg = ac.type },
    CmpItemKindColor = { fg = ac.error },
    CmpItemKindConstant = { fg = ac.type },
    CmpItemKindConstructor = { fg = ac.type },
    CmpItemKindEnum = { fg = ac.type },
    CmpItemKindEnumMember = { fg = ac.type },
    CmpItemKindEvent = { fg = ac.operator },
    CmpItemKindField = { fg = ac.func },
    CmpItemKindFile = { fg = fg.text },
    CmpItemKindFolder = { fg = ac.func },
    CmpItemKindFunction = { fg = fg.text },
    CmpItemKindInterface = { fg = ac.type },
    CmpItemKindKeyword = { fg = ac.keyword },
    CmpItemKindMethod = { fg = fg.text },
    CmpItemKindModule = { fg = fg.text },
    CmpItemKindOperator = { fg = ac.operator },
    CmpItemKindProperty = { fg = ac.func },
    CmpItemKindReference = { fg = ac.tag },
    CmpItemKindSnippet = { fg = ac.number },
    CmpItemKindStruct = { fg = ac.type },
    CmpItemKindText = { fg = fg.subtext },
    CmpItemKindTypeParameter = { fg = ac.type },
    CmpItemKindUnit = { fg = ac.type },
    CmpItemKindValue = { fg = ac.type },
    CmpItemKindVariable = { fg = fg.text },

    -- Ghost text
    CmpGhostText = { fg = fg.overlay },
  }
end

return M
