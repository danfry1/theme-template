local M = {}

function M.hex_to_rgb(hex)
  hex = hex:gsub("#", "")
  return {
    r = tonumber(hex:sub(1, 2), 16),
    g = tonumber(hex:sub(3, 4), 16),
    b = tonumber(hex:sub(5, 6), 16),
  }
end

function M.rgb_to_hex(rgb)
  return string.format("#%02x%02x%02x", rgb.r, rgb.g, rgb.b)
end

function M.blend(fg, bg, alpha)
  local fg_rgb = M.hex_to_rgb(fg)
  local bg_rgb = M.hex_to_rgb(bg)
  local function clamp(v)
    return math.min(255, math.max(0, math.floor(v + 0.5)))
  end
  return M.rgb_to_hex({
    r = clamp(fg_rgb.r * alpha + bg_rgb.r * (1 - alpha)),
    g = clamp(fg_rgb.g * alpha + bg_rgb.g * (1 - alpha)),
    b = clamp(fg_rgb.b * alpha + bg_rgb.b * (1 - alpha)),
  })
end

function M.darken(hex, amount)
  return M.blend(hex, "#000000", 1 - amount)
end

function M.lighten(hex, amount)
  return M.blend(hex, "#ffffff", 1 - amount)
end

return M
