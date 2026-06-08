local M = {}

function M.get(p, config)
  local fg = p.foregrounds
  local bg = p.backgrounds
  local ac = p.accents

  return {
    NeoTreeNormal = { fg = fg.text, bg = bg.dim },
    NeoTreeNormalNC = { fg = fg.text, bg = bg.dim },
    NeoTreeEndOfBuffer = { fg = bg.dim, bg = bg.dim },
    NeoTreeCursorLine = { bg = bg.surface0 },

    NeoTreeRootName = { fg = ac.keyword, bold = true },
    NeoTreeDirectoryName = { fg = ac.func },
    NeoTreeDirectoryIcon = { fg = ac.func },
    NeoTreeFileName = { fg = fg.text },
    NeoTreeFileIcon = { fg = fg.subtext },
    NeoTreeFileNameOpened = { fg = fg.text, bold = true },

    NeoTreeIndentMarker = { fg = bg.surface1 },
    NeoTreeExpander = { fg = fg.overlay },
    NeoTreeSymbolicLinkTarget = { fg = ac.tag },
    NeoTreeFloatTitle = { fg = ac.keyword, bold = true },
    NeoTreeTitleBar = { fg = bg.base, bg = ac.keyword, bold = true },
    NeoTreeWinSeparator = { fg = bg.dim, bg = bg.dim },

    NeoTreeFilterTerm = { fg = ac.type, bold = true },
    NeoTreeModified = { fg = ac.func },
    NeoTreeDimText = { fg = fg.overlay },
    NeoTreeHiddenByName = { fg = fg.overlay },

    -- Git status
    NeoTreeGitAdded = { fg = ac.string },
    NeoTreeGitConflict = { fg = ac.error },
    NeoTreeGitDeleted = { fg = ac.error },
    NeoTreeGitIgnored = { fg = fg.overlay },
    NeoTreeGitModified = { fg = ac.func },
    NeoTreeGitUnstaged = { fg = ac.number },
    NeoTreeGitUntracked = { fg = ac.string },
    NeoTreeGitStaged = { fg = ac.string },
  }
end

return M
