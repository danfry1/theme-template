local M = {}

function M.get(p, config)
  local fg = p.foregrounds
  local bg = p.backgrounds
  local ac = p.accents

  return {
    LazyH1 = { fg = bg.base, bg = ac.keyword, bold = true },
    LazyH2 = { fg = ac.keyword, bold = true },
    LazyNormal = { fg = fg.text, bg = bg.surface0 },
    LazyBorder = { fg = bg.surface2, bg = bg.surface0 },

    LazyButton = { fg = fg.subtext, bg = bg.surface0 },
    LazyButtonActive = { fg = fg.text, bg = bg.surface1, bold = true },

    LazyComment = { fg = fg.comment },
    LazyCommit = { fg = ac.tag },
    LazyCommitIssue = { fg = ac.operator },
    LazyCommitType = { fg = ac.keyword, bold = true },
    LazyDir = { fg = ac.func },
    LazyUrl = { fg = ac.func, underline = true },
    LazySpecial = { fg = ac.tag },

    LazyProgressDone = { fg = ac.keyword },
    LazyProgressTodo = { fg = bg.surface2 },

    LazyReasonCmd = { fg = ac.type },
    LazyReasonEvent = { fg = ac.operator },
    LazyReasonFt = { fg = ac.tag },
    LazyReasonImport = { fg = ac.func },
    LazyReasonKeys = { fg = ac.number },
    LazyReasonPlugin = { fg = ac.keyword },
    LazyReasonRuntime = { fg = fg.subtext },
    LazyReasonSource = { fg = ac.string },
    LazyReasonStart = { fg = fg.text },

    LazyTaskError = { fg = ac.error },
    LazyTaskOutput = { fg = fg.subtext },
  }
end

return M
