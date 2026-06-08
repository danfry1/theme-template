local M = {}

function M.get(p, config)
  local fg = p.foregrounds
  local bg = p.backgrounds
  local ac = p.accents
  local util = require("example.util")

  return {
    -- Sign column signs
    GitSignsAdd = { fg = ac.string },
    GitSignsChange = { fg = ac.func },
    GitSignsDelete = { fg = ac.error },
    GitSignsTopdelete = { fg = ac.error },
    GitSignsChangedelete = { fg = ac.func },
    GitSignsUntracked = { fg = ac.number },

    -- Line number variants (same fg)
    GitSignsAddNr = { fg = ac.string },
    GitSignsChangeNr = { fg = ac.func },
    GitSignsDeleteNr = { fg = ac.error },
    GitSignsTopdeleteNr = { fg = ac.error },
    GitSignsChangedeleteNr = { fg = ac.func },
    GitSignsUntrackedNr = { fg = ac.number },

    -- Line highlight variants (alpha blended onto mantle)
    GitSignsAddLn = { fg = ac.string, bg = util.blend(ac.string, bg.dim, 0.12) },
    GitSignsChangeLn = { fg = ac.func, bg = util.blend(ac.func, bg.dim, 0.12) },
    GitSignsDeleteLn = { fg = ac.error, bg = util.blend(ac.error, bg.dim, 0.12) },
    GitSignsTopdeleteLn = { fg = ac.error, bg = util.blend(ac.error, bg.dim, 0.12) },
    GitSignsChangedeleteLn = { fg = ac.func, bg = util.blend(ac.func, bg.dim, 0.12) },
    GitSignsUntrackedLn = { fg = ac.number, bg = util.blend(ac.number, bg.dim, 0.12) },

    -- Inline word-diff highlights
    GitSignsAddInline = { bg = util.blend(ac.string, bg.base, 0.25) },
    GitSignsChangeInline = { bg = util.blend(ac.func, bg.base, 0.25) },
    GitSignsDeleteInline = { bg = util.blend(ac.error, bg.base, 0.25) },

    -- Blame
    GitSignsCurrentLineBlame = { fg = fg.overlay, italic = true },
    GitSignsCurrentLineBlameNc = { fg = fg.overlay },
  }
end

return M
