local M = {}

function M.get(p, config)
  local fg = p.foregrounds
  local bg = p.backgrounds
  local ac = p.accents

  return {
    -- dashboard-nvim
    DashboardHeader = { fg = ac.keyword },
    DashboardFooter = { fg = fg.overlay, italic = true },
    DashboardDesc = { fg = fg.subtext },
    DashboardKey = { fg = ac.type, bold = true },
    DashboardIcon = { fg = ac.func },
    DashboardShortCut = { fg = ac.operator },
    DashboardCenter = { fg = fg.text },
    DashboardProjectTitle = { fg = ac.keyword, bold = true },
    DashboardProjectTitleIcon = { fg = ac.func },
    DashboardProjectIcon = { fg = ac.func },
    DashboardMruTitle = { fg = ac.keyword, bold = true },
    DashboardMruIcon = { fg = ac.func },
    DashboardFiles = { fg = fg.text },

    -- alpha-nvim
    AlphaHeader = { fg = ac.keyword },
    AlphaButtons = { fg = fg.text },
    AlphaShortcut = { fg = ac.type, bold = true },
    AlphaFooter = { fg = fg.overlay, italic = true },
  }
end

return M
