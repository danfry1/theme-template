local M = {}

local CORE_MODULES = {
  "example.groups.editor",
  "example.groups.syntax",
  "example.groups.lsp",
}

local PLUGIN_MODULES = {
  "example.groups.plugins.telescope",
  "example.groups.plugins.cmp",
  "example.groups.plugins.gitsigns",
  "example.groups.plugins.indent-blankline",
  "example.groups.plugins.which-key",
  "example.groups.plugins.lazy",
  "example.groups.plugins.neo-tree",
  "example.groups.plugins.oil",
  "example.groups.plugins.mini",
  "example.groups.plugins.notify",
  "example.groups.plugins.noice",
  "example.groups.plugins.trouble",
  "example.groups.plugins.flash",
  "example.groups.plugins.dashboard",
  "example.groups.plugins.snacks",
}

function M.apply(config)
  local p = vim.deepcopy(require("example.palette"))

  -- Apply palette overrides before any modules see the palette
  if config.palette_overrides then
    local overrides = config.palette_overrides
    if type(overrides) == "function" then
      overrides = overrides(p, "dark")
    end
    if type(overrides) == "table" then
      p = vim.tbl_deep_extend("force", p, overrides)
    end
  end

  local groups = {}

  local function load_module(mod, is_core)
    local ok, module_groups = pcall(require, mod)
    if not ok then
      if is_core then
        vim.notify(
          "[example] Failed to load core module " .. mod .. ": " .. tostring(module_groups),
          vim.log.levels.ERROR
        )
      end
      return
    end

    local get_ok, result = pcall(module_groups.get, p, config)
    if not get_ok then
      vim.notify("[example] Error in " .. mod .. ".get(): " .. tostring(result), vim.log.levels.ERROR)
      return
    end

    for k, v in pairs(result) do
      groups[k] = v
    end
  end

  for _, mod in ipairs(CORE_MODULES) do
    load_module(mod, true)
  end

  for _, mod in ipairs(PLUGIN_MODULES) do
    load_module(mod, false)
  end

  -- Apply custom highlights
  if config.custom_highlights then
    local custom = config.custom_highlights
    if type(custom) == "function" then
      custom = custom(p, "dark")
    end
    if type(custom) == "table" then
      for k, v in pairs(custom) do
        groups[k] = vim.tbl_extend("force", groups[k] or {}, v)
      end
    end
  end

  for group, settings in pairs(groups) do
    vim.api.nvim_set_hl(0, group, settings)
  end

  -- Terminal colors
  vim.g.terminal_color_0 = p.ansi.black
  vim.g.terminal_color_1 = p.ansi.red
  vim.g.terminal_color_2 = p.ansi.green
  vim.g.terminal_color_3 = p.ansi.yellow
  vim.g.terminal_color_4 = p.ansi.blue
  vim.g.terminal_color_5 = p.ansi.magenta
  vim.g.terminal_color_6 = p.ansi.cyan
  vim.g.terminal_color_7 = p.ansi.white
  vim.g.terminal_color_8 = p.ansi.brightBlack
  vim.g.terminal_color_9 = p.ansi.brightRed
  vim.g.terminal_color_10 = p.ansi.brightGreen
  vim.g.terminal_color_11 = p.ansi.brightYellow
  vim.g.terminal_color_12 = p.ansi.brightBlue
  vim.g.terminal_color_13 = p.ansi.brightMagenta
  vim.g.terminal_color_14 = p.ansi.brightCyan
  vim.g.terminal_color_15 = p.ansi.brightWhite
end

return M
