local M = {}

function M.get(p, config)
  local fg = p.foregrounds
  local bg = p.backgrounds
  local ac = p.accents

  return {
    -- trouble.nvim v3
    TroubleNormal = { fg = fg.text, bg = bg.dim },
    TroubleNormalNC = { fg = fg.text, bg = bg.dim },
    TroubleCount = { fg = ac.keyword, bold = true },
    TroubleDirectory = { fg = ac.func },
    TroubleFileName = { fg = fg.text, bold = true },
    TroubleIconDirectory = { fg = ac.func },
    TroubleIconFile = { fg = fg.text },
    TroubleIndent = { fg = bg.surface1 },
    TroubleIndentFoldClosed = { fg = bg.surface2 },
    TroubleIndentFoldOpen = { fg = bg.surface1 },
    TroubleIndentLast = { fg = bg.surface1 },
    TroubleIndentMiddle = { fg = bg.surface1 },
    TroubleIndentTop = { fg = bg.surface1 },
    TroubleIndentWs = { fg = bg.surface1 },
    TroublePos = { fg = fg.overlay },
    TroublePreview = { bg = bg.surface0 },
    TroubleSource = { fg = fg.overlay },
    TroubleText = { fg = fg.text },
    TroubleCode = { fg = fg.overlay },
  }
end

return M
