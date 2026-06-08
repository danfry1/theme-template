local M = {}

function M.get(p, config)
  local fg = p.foregrounds
  local bg = p.backgrounds
  local ac = p.accents

  return {
    -- mini.statusline
    MiniStatuslineModeNormal = { fg = bg.shadow, bg = ac.keyword, bold = true },
    MiniStatuslineModeInsert = { fg = bg.shadow, bg = ac.string, bold = true },
    MiniStatuslineModeVisual = { fg = bg.shadow, bg = ac.operator, bold = true },
    MiniStatuslineModeReplace = { fg = bg.shadow, bg = ac.error, bold = true },
    MiniStatuslineModeCommand = { fg = bg.shadow, bg = ac.number, bold = true },
    MiniStatuslineModeOther = { fg = bg.shadow, bg = ac.tag, bold = true },
    MiniStatuslineDevinfo = { fg = fg.subtext, bg = bg.surface1 },
    MiniStatuslineFilename = { fg = fg.subtext, bg = bg.dim },
    MiniStatuslineFileinfo = { fg = fg.subtext, bg = bg.surface1 },
    MiniStatuslineInactive = { fg = fg.overlay, bg = bg.dim },

    -- mini.tabline
    MiniTablineCurrent = { fg = fg.text, bg = bg.base, bold = true },
    MiniTablineVisible = { fg = fg.subtext, bg = bg.surface0 },
    MiniTablineHidden = { fg = fg.overlay, bg = bg.dim },
    MiniTablineModifiedCurrent = { fg = ac.string, bg = bg.base, bold = true },
    MiniTablineModifiedVisible = { fg = ac.string, bg = bg.surface0 },
    MiniTablineModifiedHidden = { fg = ac.string, bg = bg.dim },
    MiniTablineFill = { bg = bg.shadow },
    MiniTablineTabpagesection = { fg = bg.shadow, bg = ac.keyword, bold = true },

    -- mini.cursorword
    MiniCursorword = { bg = bg.surface1 },
    MiniCursorwordCurrent = { bg = bg.surface1 },

    -- mini.indentscope
    MiniIndentscopeSymbol = { fg = ac.keyword },

    -- mini.pick
    MiniPickBorder = { fg = bg.surface2, bg = bg.surface0 },
    MiniPickBorderBusy = { fg = ac.number, bg = bg.surface0 },
    MiniPickBorderText = { fg = ac.keyword, bg = bg.surface0, bold = true },
    MiniPickIconDirectory = { fg = ac.func },
    MiniPickIconFile = { fg = fg.text },
    MiniPickHeader = { fg = ac.keyword, bold = true },
    MiniPickMatchCurrent = { bg = bg.surface1, bold = true },
    MiniPickMatchMarked = { fg = ac.string, bg = bg.surface1 },
    MiniPickMatchRanges = { fg = ac.type, bold = true },
    MiniPickNormal = { fg = fg.text, bg = bg.surface0 },
    MiniPickPreviewLine = { bg = bg.surface1 },
    MiniPickPreviewRegion = { bg = bg.surface1 },
    MiniPickPrompt = { fg = ac.keyword, bg = bg.surface0 },

    -- mini.jump / mini.jump2d
    MiniJump = { fg = bg.shadow, bg = ac.type, bold = true },
    MiniJump2dSpot = { fg = ac.type, bold = true },
    MiniJump2dSpotAhead = { fg = ac.tag },
    MiniJump2dSpotUnique = { fg = ac.type, bold = true },
    MiniJump2dDim = { fg = fg.overlay },

    -- mini.hipatterns
    MiniHipatternsFixme = { fg = bg.shadow, bg = ac.error, bold = true },
    MiniHipatternsHack = { fg = bg.shadow, bg = ac.number, bold = true },
    MiniHipatternsNote = { fg = bg.shadow, bg = ac.func, bold = true },
    MiniHipatternsTodo = { fg = bg.shadow, bg = ac.string, bold = true },

    -- mini.diff
    MiniDiffSignAdd = { fg = ac.string },
    MiniDiffSignChange = { fg = ac.func },
    MiniDiffSignDelete = { fg = ac.error },
    MiniDiffOverAdd = { link = "DiffAdd" },
    MiniDiffOverChange = { link = "DiffChange" },
    MiniDiffOverContext = { link = "DiffChange" },
    MiniDiffOverDelete = { link = "DiffDelete" },

    -- mini.files
    MiniFilesDirectory = { fg = ac.func, bold = true },
    MiniFilesFile = { fg = fg.text },
    MiniFilesCursorLine = { bg = bg.surface1 },
    MiniFilesNormal = { fg = fg.text, bg = bg.surface0 },
    MiniFilesBorder = { fg = bg.surface2, bg = bg.surface0 },
    MiniFilesBorderModified = { fg = ac.number, bg = bg.surface0 },
    MiniFilesTitle = { fg = ac.keyword, bg = bg.surface0, bold = true },
    MiniFilesTitleFocused = { fg = ac.type, bg = bg.surface0, bold = true },

    -- mini.notify
    MiniNotifyBorder = { fg = bg.surface2, bg = bg.surface0 },
    MiniNotifyNormal = { fg = fg.text, bg = bg.surface0 },
    MiniNotifyTitle = { fg = ac.keyword, bg = bg.surface0, bold = true },
  }
end

return M
