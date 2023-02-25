local M = {}

M.setup = function()
  require("catppuccin").setup({
    transparent_background = false,
    no_italic = true,
    no_bold = true,
  })
end

return M
