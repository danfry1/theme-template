local M = {}

function M.get(p, config)
  local fg = p.foregrounds
  local ac = p.accents

  return {
    OilDir = { fg = ac.func, bold = true },
    OilDirIcon = { fg = ac.func },
    OilLink = { fg = ac.tag },
    OilLinkTarget = { fg = fg.overlay, italic = true },
    OilFile = { fg = fg.text },
    OilSocket = { fg = ac.keyword },

    -- Change type indicators
    OilCreate = { fg = ac.string },
    OilDelete = { fg = ac.error },
    OilMove = { fg = ac.number },
    OilCopy = { fg = ac.func },
    OilChange = { fg = ac.func },
    OilRestore = { fg = ac.tag },
    OilPurge = { fg = ac.error, bold = true },
    OilTrash = { fg = ac.error },
    OilTrashSourcePath = { fg = fg.overlay, italic = true },
  }
end

return M
