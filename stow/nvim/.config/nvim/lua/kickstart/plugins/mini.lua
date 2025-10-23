-- Collection of various small independent plugins/modules
return {
  {
    'echasnovski/mini.nvim',
    enabled = vim.g.vscode == nil,
    init = function()
      -- Better Around/Inside textobjects
      require('mini.ai').setup { n_lines = 500 }

      -- Disabled mini.surround to restore default 's' behavior (substitute char)
      -- require('mini.surround').setup()

      -- Minimap
      local map = require 'mini.map'

      map.setup {
        integrations = {
          map.gen_integration.builtin_search(),
          map.gen_integration.diagnostic(),
          map.gen_integration.gitsigns(),
        },
        window = {
          winblend = 0,
        },
      }

      MiniMap.open()
      vim.keymap.set('n', '<leader>mt', MiniMap.toggle)

      -- Statusline
      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = vim.g.have_nerd_font }

      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end
    end,
  },
}
