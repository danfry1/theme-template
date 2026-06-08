local M = {}

function M.get(p, config)
  local fg = p.foregrounds
  local bg = p.backgrounds
  local ac = p.accents

  return {
    -- Explorer / Picker git status (applied to filenames when git_status_hl = true)
    SnacksPickerGitStatusAdded = { fg = ac.string },
    SnacksPickerGitStatusModified = { fg = ac.func },
    SnacksPickerGitStatusDeleted = { fg = ac.error },
    SnacksPickerGitStatusRenamed = { fg = ac.func },
    SnacksPickerGitStatusUntracked = { fg = ac.string },
    SnacksPickerGitStatusIgnored = { fg = fg.overlay },
    SnacksPickerGitStatusUnmerged = { fg = ac.error },
    SnacksPickerGitStatusStaged = { fg = ac.tag },

    -- Picker UI
    SnacksPickerMatch = { fg = ac.type, bold = true },
    SnacksPickerPrompt = { fg = ac.keyword },
    SnacksPickerDir = { fg = fg.overlay },
    SnacksPickerFile = { fg = fg.text },
    SnacksPickerDirectory = { fg = ac.func },
    SnacksPickerPathIgnored = { fg = fg.overlay },
    SnacksPickerPathHidden = { fg = fg.overlay },
    SnacksPickerDimmed = { fg = fg.overlay },
    SnacksPickerTotals = { fg = fg.overlay },
    SnacksPickerTree = { fg = bg.surface2 },

    -- Dashboard
    SnacksDashboardHeader = { fg = ac.keyword },
    SnacksDashboardFooter = { fg = fg.overlay, italic = true },
    SnacksDashboardDesc = { fg = fg.subtext },
    SnacksDashboardKey = { fg = ac.type, bold = true },
    SnacksDashboardIcon = { fg = ac.func },
    SnacksDashboardSpecial = { fg = ac.keyword },
    SnacksDashboardDir = { fg = fg.overlay },
    SnacksDashboardFile = { fg = fg.text },
    SnacksDashboardTitle = { fg = ac.keyword, bold = true },

    -- Notifier
    SnacksNotifierInfo = { fg = ac.func },
    SnacksNotifierWarn = { fg = ac.number },
    SnacksNotifierError = { fg = ac.error },
    SnacksNotifierDebug = { fg = fg.overlay },
    SnacksNotifierTrace = { fg = ac.keyword },
    SnacksNotifierIconInfo = { fg = ac.func },
    SnacksNotifierIconWarn = { fg = ac.number },
    SnacksNotifierIconError = { fg = ac.error },
    SnacksNotifierIconDebug = { fg = fg.overlay },
    SnacksNotifierIconTrace = { fg = ac.keyword },
  }
end

return M
