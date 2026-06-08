local M = {}

function M.get(p, config)
  local fg = p.foregrounds
  local bg = p.backgrounds
  local ac = p.accents

  return {
    NoiceCmdline = { fg = fg.text, bg = bg.surface0 },
    NoiceCmdlineIcon = { fg = ac.keyword },
    NoiceCmdlineIconSearch = { fg = ac.number },
    NoiceCmdlinePopup = { fg = fg.text, bg = bg.surface0 },
    NoiceCmdlinePopupBorder = { fg = bg.surface2, bg = bg.surface0 },
    NoiceCmdlinePopupBorderSearch = { fg = ac.number, bg = bg.surface0 },
    NoiceCmdlinePopupTitle = { fg = ac.keyword, bg = bg.surface0, bold = true },

    NoiceConfirm = { fg = fg.text, bg = bg.surface0 },
    NoiceConfirmBorder = { fg = ac.keyword, bg = bg.surface0 },

    NoiceMini = { fg = fg.text, bg = bg.surface0 },

    NoiceFormatProgressDone = { fg = bg.shadow, bg = ac.keyword, bold = true },
    NoiceFormatProgressTodo = { fg = fg.overlay, bg = bg.surface1 },

    NoiceLspProgressClient = { fg = ac.keyword },
    NoiceLspProgressSpinner = { fg = ac.tag },
    NoiceLspProgressTitle = { fg = fg.subtext },

    NoiceFormatEvent = { fg = fg.overlay },
    NoiceFormatKind = { fg = ac.keyword },
    NoiceFormatDate = { fg = fg.overlay },
    NoiceFormatConfirm = { fg = fg.text, bg = bg.surface0 },
    NoiceFormatConfirmDefault = { fg = bg.shadow, bg = ac.keyword, bold = true },

    NoicePopup = { fg = fg.text, bg = bg.surface0 },
    NoicePopupBorder = { fg = bg.surface2, bg = bg.surface0 },
    NoicePopupmenu = { fg = fg.text, bg = bg.surface0 },
    NoicePopupmenuBorder = { fg = bg.surface2, bg = bg.surface0 },
    NoicePopupmenuMatch = { fg = ac.type, bold = true },
    NoicePopupmenuSelected = { bg = bg.surface1, bold = true },
    NoiceScrollbar = { bg = bg.surface1 },
    NoiceScrollbarThumb = { bg = bg.surface2 },

    NoiceVirtualText = { fg = ac.func },
  }
end

return M
