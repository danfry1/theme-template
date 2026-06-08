local M = {}

local defaults = {
  transparent = false,
  italics = true,
  palette_overrides = nil,
  custom_highlights = nil,
}

M.config = vim.deepcopy(defaults)

function M.setup(opts)
  M.config = vim.tbl_deep_extend("force", defaults, opts or {})
end

function M.load()
  if vim.g.colors_name then
    vim.cmd("hi clear")
  end
  if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
  end
  vim.g.colors_name = "example"
  vim.o.termguicolors = true
  vim.o.background = "dark"

  local ok, err = pcall(function()
    local theme = require("example.theme")
    theme.apply(M.config)
  end)
  if not ok then
    vim.notify("[example] Failed to load theme: " .. tostring(err), vim.log.levels.ERROR)
  end
end

return M
