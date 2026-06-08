local M = {}

function M.get(p, config)
  local fg = p.foregrounds
  local bg = p.backgrounds
  local ac = p.accents

  return {
    FlashBackdrop = { fg = fg.overlay },
    FlashLabel = { fg = bg.shadow, bg = ac.type, bold = true },
    FlashMatch = { fg = ac.func, bg = bg.surface1 },
    FlashCurrent = { fg = fg.text, bg = bg.surface1, bold = true },
    FlashPrompt = { fg = fg.text, bg = bg.surface0 },
    FlashPromptIcon = { fg = ac.keyword },
    FlashCursor = { fg = bg.base, bg = fg.text },
  }
end

return M
