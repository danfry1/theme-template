local M = {}

function M.get(p, config)
  local fg = p.foregrounds
  local bg = p.backgrounds
  local ac = p.accents

  return {
    NotifyERRORBorder = { fg = ac.error },
    NotifyWARNBorder = { fg = ac.number },
    NotifyINFOBorder = { fg = ac.func },
    NotifyDEBUGBorder = { fg = fg.overlay },
    NotifyTRACEBorder = { fg = ac.keyword },

    NotifyERRORIcon = { fg = ac.error },
    NotifyWARNIcon = { fg = ac.number },
    NotifyINFOIcon = { fg = ac.func },
    NotifyDEBUGIcon = { fg = fg.overlay },
    NotifyTRACEIcon = { fg = ac.keyword },

    NotifyERRORTitle = { fg = ac.error, bold = true },
    NotifyWARNTitle = { fg = ac.number, bold = true },
    NotifyINFOTitle = { fg = ac.func, bold = true },
    NotifyDEBUGTitle = { fg = fg.overlay, bold = true },
    NotifyTRACETitle = { fg = ac.keyword, bold = true },

    NotifyERRORBody = { fg = fg.text, bg = bg.surface0 },
    NotifyWARNBody = { fg = fg.text, bg = bg.surface0 },
    NotifyINFOBody = { fg = fg.text, bg = bg.surface0 },
    NotifyDEBUGBody = { fg = fg.text, bg = bg.surface0 },
    NotifyTRACEBody = { fg = fg.text, bg = bg.surface0 },

    NotifyBackground = { bg = bg.surface0 },
  }
end

return M
