local M = {}

function M.get(p, config)
  local fg = p.foregrounds
  local bg = p.backgrounds
  local ac = p.accents

  return {
    WhichKey = { fg = ac.keyword },
    WhichKeyGroup = { fg = ac.func },
    WhichKeyDesc = { fg = fg.subtext },
    WhichKeySeparator = { fg = fg.overlay },
    WhichKeyValue = { fg = fg.overlay },
    WhichKeyBorder = { fg = bg.surface2, bg = bg.surface0 },
    WhichKeyFloat = { fg = fg.text, bg = bg.surface0 },
    WhichKeyTitle = { fg = ac.keyword, bg = bg.surface0, bold = true },
    WhichKeyIcon = { fg = ac.keyword },
  }
end

return M
