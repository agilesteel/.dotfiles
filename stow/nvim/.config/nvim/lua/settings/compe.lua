local M = {}

-- I use this instead of nvim-completion mainly because there is a giant speed
-- difference and with a lot of the Scala projects I work in that may have huge
-- files and large code bases, this makes a _huge_ difference.
-- https://github.com/hrsh7th/nvim-compe
M.setup = function()
  require("compe").setup({
    enabled = true,
    debug = false,
    min_length = 1,

    source = {
      path = true,
      buffer = true,
      vsnip = {
        filetypes = { "scala", "html", "javascript", "lua", "java", "go" },
      },
      nvim_lsp = {
        priority = 1000,
        filetypes = { "scala", "html", "javascript", "lua", "java", "go" },
      },
    },
  })
end

return M
