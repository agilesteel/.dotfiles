-- Fuzzy Finder (files, lsp, etc)
return {
  {
    'nvim-telescope/telescope.nvim',
    enabled = vim.g.vscode == nil,
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- find_files with toggleable hidden / gitignored files (<M-h> / <M-g> inside the picker)
      local include = { hidden = false, ignored = false }

      local function find_files(opts)
        opts = opts or {}
        opts.hidden = include.hidden
        opts.no_ignore = include.ignored
        opts.file_ignore_patterns = include.hidden and { '^%.git/' } or nil
        local extra = {}
        if include.hidden then
          table.insert(extra, '+hidden')
        end
        if include.ignored then
          table.insert(extra, '+ignored')
        end
        opts.prompt_title = 'Find Files' .. (#extra > 0 and ' (' .. table.concat(extra, ' ') .. ')' or '')
        require('telescope.builtin').find_files(opts)
      end

      local function toggle(flag)
        return function(prompt_bufnr)
          local state = require 'telescope.actions.state'
          local text = state.get_current_line()
          local cwd = state.get_current_picker(prompt_bufnr).cwd
          require('telescope.actions').close(prompt_bufnr)
          include[flag] = not include[flag]
          find_files { default_text = text, cwd = cwd }
        end
      end

      require('telescope').setup {
        pickers = {
          find_files = {
            mappings = {
              i = { ['<M-h>'] = toggle 'hidden', ['<M-g>'] = toggle 'ignored' },
              n = { ['<M-h>'] = toggle 'hidden', ['<M-g>'] = toggle 'ignored' },
            },
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
        defaults = {
          layout_strategy = 'vertical',
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- Keymaps
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<C-p>', find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      vim.keymap.set('n', '<leader>sn', function()
        find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },
}
