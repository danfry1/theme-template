local M = {}

function M.get(p, config)
  local bg = p.backgrounds

  return {
    IblIndent = { fg = bg.surface0 },
    IblScope = { fg = bg.surface2 },
    IblWhitespace = { fg = bg.surface0 },

    -- Legacy indent-blankline v2 groups (kept for compatibility)
    IndentBlanklineChar = { fg = bg.surface0 },
    IndentBlanklineContextChar = { fg = bg.surface2 },
    IndentBlanklineSpaceChar = { fg = bg.surface0 },
    IndentBlanklineSpaceCharBlankline = { fg = bg.surface0 },
  }
end

return M
