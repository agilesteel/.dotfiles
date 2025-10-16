--[[

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================
========                                    .-----.          ========
========         .----------------------.   | === |          ========
========         |.-""""""""""""""""""-.|   |-----|          ========
========         ||                    ||   | === |          ========
========         ||   KICKSTART.NVIM   ||   |-----|          ========
========         ||                    ||   | === |          ========
========         ||                    ||   |-----|          ========
========         ||:Tutor              ||   |:::::|          ========
========         |'-..................-'|   |____o|          ========
========         `"")----------------(""`   ___________      ========
========        /::::::::::|  |::::::::::\  \ no mouse \     ========
========       /:::========|  |==hjkl==:::\  \ required \    ========
========      '""""""""""""'  '""""""""""""'  '""""""""""'   ========
========                                                     ========
=====================================================================
=====================================================================

What is Kickstart?

  Kickstart.nvim is *not* a distribution.

  Kickstart.nvim is a starting point for your own configuration.
    The goal is that you can read every line of code, top-to-bottom, understand
    what your configuration is doing, and modify it to suit your needs.

    Once you've done that, you can start exploring, configuring and tinkering to
    make Neovim your own! That might mean leaving Kickstart just the way it is for a while
    or immediately breaking it into modular pieces. It's up to you!

    If you don't know anything about Lua, I recommend taking some time to read through
    a guide. One possible example which will only take 10-15 minutes:
      - https://learnxinyminutes.com/docs/lua/

    After understanding a bit more about Lua, you can use `:help lua-guide` as a
    reference for how Neovim integrates Lua.
    - :help lua-guide
    - (or HTML version): https://neovim.io/doc/user/lua-guide.html

Kickstart Guide:

  TODO: The very first thing you should do is to run the command `:Tutor` in Neovim.

    If you don't know what this means, type the following:
      - <escape key>
      - :
      - Tutor
      - <enter key>

   (If you already know the Neovim basics, you can skip this step.)

  Once you've completed that, you can continue working through **AND READING** the rest
  of the kickstart init.lua.

  Next, run AND READ `:help`.
    This will open up a help window with some basic information
    about reading, navigating and searching the builtin help documentation.

    This should be the first place you go to look when you're stuck or confused
    with something. It's one of my favorite Neovim features.

    MOST IMPORTANTLY, we provide a keymap "<space>sh" to [s]earch the [h]elp documentation,
    which is very useful when you're not exactly sure of what you're looking for.

  I have left several `:help X` comments throughout the init.lua
    These are hints about where to find more information about the relevant settings,
    plugins or Neovim features used in Kickstart.

   NOTE: Look for lines like this

    Throughout the file. These are for you, the reader, to help you understand what is happening.
    Feel free to delete them once you know what you're doing, but they should serve as a guide
    for when you are first encountering a few different constructs in your Neovim config.

If you experience any errors while trying to install kickstart, run `:checkhealth` for more info.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now! :)
--]]

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.autoindent = true -- not sure if I need this
vim.opt.breakindent = true -- Enable break indent
vim.opt.encoding = 'utf-8' -- the encoding displayed
vim.opt.expandtab = true -- converts tabs to spaces
vim.opt.hidden = true
vim.opt.linebreak = true -- don't break words in half
vim.opt.mouse = 'a' -- enable mouse
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 2 -- 2 spaces for a tab
vim.opt.showmode = false
vim.opt.showtabline = 2 -- always show tabline
vim.opt.smarttab = true -- figures out whether to use 2 or 4 spaces
vim.opt.tabstop = 2 -- insert 2 spaces instead of a tab
vim.opt.termguicolors = true
vim.opt.undofile = true -- Save undo history

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = 'yes' -- Keep signcolumn on by default

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.opt.inccommand = 'split' -- Preview substitutions live, as you type!

-- Show which line your cursor is on
vim.opt.cursorline = true
vim.opt.cursorlineopt = 'number'

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Use alt + hjkl to resize windows
vim.keymap.set('n', '<M-j>', ':resize +2<CR>', { desc = 'Resize window down', silent = true })
vim.keymap.set('n', '<M-k>', ':resize -2<CR>', { desc = 'Resize window up', silent = true })
vim.keymap.set('n', '<M-h>', ':vertical resize -2<CR>', { desc = 'Resize window left', silent = true })
vim.keymap.set('n', '<M-l>', ':vertical resize +2<CR>', { desc = 'Resize window right', silent = true })

vim.keymap.set('i', 'jk', '<Esc>', { silent = true })

-- Switching buffers
vim.keymap.set('n', '<C-PageDown>', ':bnext<CR>', { desc = 'Next buffer', silent = true })
vim.keymap.set('n', '<C-PageUp>', ':bprevious<CR>', { desc = 'Previous buffer', silent = true })

-- Alternative way to save
vim.keymap.set('n', '<C-s>', ':update<CR>', { desc = 'Save', silent = true })
vim.keymap.set('v', '<C-s>', '<C-c>:update<CR>gv', { desc = 'Save', silent = true })
vim.keymap.set('i', '<C-s>', '<C-o>:update<CR>', { desc = 'Save', silent = true })

vim.keymap.set('n', '<C-c>', 'Esc')

-- Indent and then immediately mark the line again
vim.keymap.set('v', '<', '<gv', { desc = 'Indent left' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent right' })

vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down and center screen' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up and center screen' })

vim.keymap.set('n', '<Esc>', ':noh<CR>', { desc = 'Disable search highlighting', silent = true })
vim.keymap.set('n', '<leader>w', ':bw<CR>', { desc = 'Close buffer', silent = true })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- stop newline continuation of comments
vim.api.nvim_create_autocmd('BufEnter', {
  callback = function()
    vim.opt.formatoptions = vim.opt.formatoptions - { 'c', 'r', 'o' }
  end,
})

-- switch back to regular numbers in insert mode
-- Create an augroup named 'numbertoggle'
local numbertoggle_group = vim.api.nvim_create_augroup('numbertoggle', { clear = true })

-- Define the autocommand for enabling relative line numbers
vim.api.nvim_create_autocmd({ 'BufEnter', 'FocusGained', 'InsertLeave', 'WinEnter' }, {
  group = numbertoggle_group,
  pattern = '*',
  callback = function()
    if vim.wo.number and vim.api.nvim_get_mode().mode ~= 'i' then
      vim.wo.relativenumber = true
    end
  end,
})

-- Define the autocommand for disabling relative line numbers
vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost', 'InsertEnter', 'WinLeave' }, {
  group = numbertoggle_group,
  pattern = '*',
  callback = function()
    if vim.wo.number then
      vim.wo.relativenumber = false
    end
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to force a plugin to be loaded.
  --

  -- Here is a more advanced example where we pass configuration
  -- options to `gitsigns.nvim`. This is equivalent to the following Lua:
  --    require('gitsigns').setup({ ... })
  --
  -- See `:help gitsigns` to understand what the configuration keys do
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    enabled = vim.g.vscode == nil,
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 0,
      },
    },
  },

  -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  --
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `config` key, the configuration only runs
  -- after the plugin has been loaded:
  --  config = function() ... end

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    enabled = vim.g.vscode == nil,
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
      require('which-key').setup()

      -- Document existing key chains
      require('which-key').add {
        { '<leader>c', group = '[C]ode' },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      }
    end,
  },

  -- NOTE: Plugins can specify dependencies.
  --
  -- The dependencies are proper plugin specifications as well - anything
  -- you do for a plugin at the top level, you can do for a dependency.
  --
  -- Use the `dependencies` key to specify the dependencies of a particular plugin

  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    enabled = vim.g.vscode == nil,
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        -- defaults = {
        --   mappings = {
        --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        --   },
        -- },
        -- pickers = {}
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

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },

  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    enabled = vim.g.vscode == nil,
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      {
        'j-hui/fidget.nvim',
        opts = {
          notification = {
            view = {
              line_margin = 0,
            },
            window = {
              winblend = 0,
              x_padding = 0,
            },
          },
          progress = {
            ignore_done_already = true,
            ignore_empty_message = true,

            display = {
              done_ttl = 1,
              render_limit = 100,
              format_message = function(msg) -- this removes the double perecentages
                return msg.message
              end,
            },
          },
        },
      },

      -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
      -- used for completion, annotations and signatures of Neovim apis
      {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
          library = {
            -- Load luvit types when the `vim.uv` word is found
            { path = 'luvit-meta/library', words = { 'vim%.uv' } },
          },
        },
      },
      { 'Bilal2453/luvit-meta', lazy = true },
    },
    config = function()
      -- Brief aside: **What is LSP?**
      --
      -- LSP is an initialism you've probably heard, but might not understand what it is.
      --
      -- LSP stands for Language Server Protocol. It's a protocol that helps editors
      -- and language tooling communicate in a standardized fashion.
      --
      -- In general, you have a "server" which is some tool built to understand a particular
      -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
      -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
      -- processes that communicate with some "client" - in this case, Neovim!
      --
      -- LSP provides Neovim with features like:
      --  - Go to definition
      --  - Find references
      --  - Autocompletion
      --  - Symbol Search
      --  - and more!
      --
      -- Thus, Language Servers are external tools that must be installed separately from
      -- Neovim. This is where `mason` and related plugins come into play.
      --
      -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
      -- and elegantly composed help section, `:help lsp-vs-treesitter`

      --  This function gets run when an LSP attaches to a particular buffer.
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- NOTE: Remember that Lua is a real programming language, and as such it is possible
          -- to define small helper and utility functions so you don't have to repeat yourself.
          --
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map('gd', function()
            require('telescope.builtin').lsp_definitions {
              show_line = false,
            }
          end, '[G]oto [D]efinition')

          map('gs', function()
            require('metals').goto_super_method()
          end, '[G]oto [S]uper Method')

          -- Find references for the word under your cursor.
          map('gr', function()
            require('telescope.builtin').lsp_references {
              show_line = false,
              include_declaration = false,
            }
          end, '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gi', function()
            require('telescope.builtin').lsp_implementations { show_line = false, default_text = '!test ' }
          end, '[G]oto [I]mplementation')

          map('gti', function()
            require('telescope.builtin').lsp_implementations { show_line = false }
          end, '[G]oto [I]mplementation')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          -- map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          -- map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          -- map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          -- map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- LSP mappings
          -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover)
          -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation)
          -- vim.keymap.set('n', 'gr', vim.lsp.buf.references)
          vim.keymap.set('n', 'gds', vim.lsp.buf.document_symbol)
          -- vim.keymap.set('n', 'gws', vim.lsp.buf.workspace_symbol)
          map('gws', function()
            require('telescope.builtin').lsp_dynamic_workspace_symbols { show_line = false }
          end, '[G]oto [W]orkspace [S]ymbols')
          vim.keymap.set('n', '<leader>cl', vim.lsp.codelens.run)
          vim.keymap.set('n', '<leader>sh', vim.lsp.buf.signature_help)
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename)
          vim.keymap.set('n', '<leader>f', vim.lsp.buf.format)
          vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action)

          vim.keymap.set('n', '<leader>ws', function()
            require('metals').hover_worksheet()
          end)

          -- all workspace diagnostics
          vim.keymap.set('n', '<leader>aa', vim.diagnostic.setqflist)

          -- all workspace errors
          map('<leader>ae', function()
            require('telescope.builtin').diagnostics { severity = vim.diagnostic.severity.ERROR }
          end, '[A]ll [E]rrors')

          -- all workspace warnings
          map('<leader>aw', function()
            require('telescope.builtin').diagnostics { severity = vim.diagnostic.severity.WARN }
          end, '[A]ll [W]arnings')

          -- buffer diagnostics only
          vim.keymap.set('n', '<leader>d', vim.diagnostic.setloclist)
          vim.keymap.set('n', '<leader>[c', function()
            require('trouble').prev { mode = 'diagnostics' }
            require('trouble').jump_close { mode = 'diagnostics' }
          end)

          vim.keymap.set('n', '<leader>]c', function()
            require('trouble').next { mode = 'diagnostics' }
            require('trouble').jump_close { mode = 'diagnostics' }
          end)

          -- Example mappings for usage with nvim-dap. If you don't use that, you can
          -- skip these
          vim.keymap.set('n', '<leader>dc', function()
            require('dap').continue()
          end)

          vim.keymap.set('n', '<leader>dr', function()
            require('dap').repl.toggle()
          end)

          vim.keymap.set('n', '<leader>dK', function()
            require('dap.ui.widgets').hover()
          end)

          vim.keymap.set('n', '<leader>dt', function()
            require('dap').toggle_breakpoint()
          end)

          vim.keymap.set('n', '<leader>dso', function()
            require('dap').step_over()
          end)

          vim.keymap.set('n', '<leader>dsi', function()
            require('dap').step_into()
          end)

          vim.keymap.set('n', '<leader>dl', function()
            require('dap').run_last()
          end)

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        -- clangd = {},
        -- gopls = {},
        -- pyright = {},
        -- rust_analyzer = {},
        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
        --
        -- Some languages (like typescript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim
        --
        -- But for many setups, the LSP (`tsserver`) will work just fine
        -- tsserver = {},
        --

        lua_ls = {
          -- cmd = {...},
          -- filetypes = { ...},
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }

      -- Ensure the servers and tools above are installed
      --  To check the current status of installed tools and/or manually install
      --  other tools, you can run
      --    :Mason
      --
      --  You can press `g?` for help in this menu.
      require('mason').setup()

      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },

  { -- Autoformat
    'stevearc/conform.nvim',
    enabled = vim.g.vscode == nil,
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        return {
          timeout_ms = 500,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use a sub-list to tell conform to run *until* a formatter
        -- is found.
        -- javascript = { { "prettierd", "prettier" } },
      },
    },
  },

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    enabled = vim.g.vscode == nil,
    event = 'InsertEnter',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          -- {
          --   'rafamadriz/friendly-snippets',
          --   config = function()
          --     require('luasnip.loaders.from_vscode').lazy_load()
          --   end,
          -- },
        },
      },
      'saadparwaiz1/cmp_luasnip',

      -- Adds other completion capabilities.
      --  nvim-cmp does not ship with all sources by default. They are split
      --  into multiple repos for maintenance purposes.
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
    },
    config = function()
      -- See `:help cmp`
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {}

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },

        -- For an understanding of why these mappings were
        -- chosen, you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        mapping = cmp.mapping.preset.insert {
          -- Select the [n]ext item
          ['<C-n>'] = cmp.mapping.select_next_item(),
          -- Select the [p]revious item
          ['<C-p>'] = cmp.mapping.select_prev_item(),

          -- Scroll the documentation window [b]ack / [f]orward
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),

          -- Accept ([y]es) the completion.
          --  This will auto-import if your LSP supports it.
          --  This will expand snippets if the LSP sent a snippet.
          ['<C-y>'] = cmp.mapping.confirm { select = true },

          -- If you prefer more traditional completion keymaps,
          -- you can uncomment the following lines
          --['<CR>'] = cmp.mapping.confirm { select = true },
          --['<Tab>'] = cmp.mapping.select_next_item(),
          --['<S-Tab>'] = cmp.mapping.select_prev_item(),

          -- Manually trigger a completion from nvim-cmp.
          --  Generally you don't need this, because nvim-cmp will display
          --  completions whenever it has completion options available.
          ['<C-Space>'] = cmp.mapping.complete {},

          -- Think of <c-l> as moving to the right of your snippet expansion.
          --  So if you have a snippet that's like:
          --  function $name($args)
          --    $body
          --  end
          --
          -- <c-l> will move you to the right of each of the expansion locations.
          -- <c-h> is similar, except moving you backwards.
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),

          -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
          --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
        },
        sources = {
          {
            name = 'lazydev',
            -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
            group_index = 0,
          },
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
        },
      }
    end,
  },

  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'catppuccin/nvim',
    enabled = vim.g.vscode == nil,
    name = 'catppuccin',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      vim.cmd.colorscheme 'catppuccin-frappe'

      -- You can configure highlights by doing something like:
      -- vim.cmd.hi 'Comment gui=none'
      vim.cmd 'highlight QuickScopePrimary gui=underline cterm=underline'
      vim.cmd 'highlight QuickScopeSecondary gui=nocombine cterm=nocombine'
      vim.cmd 'highlight Comment ctermbg=NONE ctermfg=167 guibg=NONE guifg=#ff5252 cterm=NONE gui=NONE'
      vim.cmd 'highlight TreesitterContext guibg=#292c3c'
      vim.cmd 'highlight TreesitterContextLineNumber guibg=#292c3c'
      vim.cmd 'highlight TreesitterContextBottom gui=NONE'
      vim.cmd 'highlight TreesitterContextLineNumberBottom gui=NONE'
      vim.cmd 'highlight FloatBorder guifg=#626880'
      vim.cmd 'highlight DiagnosticUnderlineInfo gui=nocombine cterm=nocombine' -- disable underline for now
      vim.cmd 'highlight DiagnosticUnderlineWarn gui=nocombine cterm=nocombine' -- disable underline for now
      vim.cmd 'highlight DiagnosticUnderlineError gui=nocombine cterm=nocombine' -- disable underline for now
      -- https://github.com/wezterm/wezterm/issues/4783#issuecomment-1911272667
      -- vim.cmd 'highlight DiagnosticUnderlineInfo cterm=undercurl gui=undercurl guisp=#be95ff'

      vim.api.nvim_set_hl(0, '@keyword', { fg = '#e78284' })
      vim.api.nvim_set_hl(0, '@keyword.conditional', { fg = '#e78284' })
      vim.api.nvim_set_hl(0, '@keyword.function', { fg = '#e78284' })
      vim.api.nvim_set_hl(0, '@keyword.import', { fg = '#e78284' })
      vim.api.nvim_set_hl(0, '@keyword.modifier', { fg = '#e78284' })
      vim.api.nvim_set_hl(0, '@keyword.operator', { fg = '#e78284' })
      vim.api.nvim_set_hl(0, '@keyword.type', { fg = '#e78284' })
      vim.api.nvim_set_hl(0, '@lsp.type.keyword', { fg = '#e78284' })
      vim.api.nvim_set_hl(0, '@lsp.type.modifier', { fg = '#e78284' })
      vim.api.nvim_set_hl(0, '@operator', { fg = '#e78284' })
      vim.api.nvim_set_hl(0, '@punctuation.bracket', { fg = '#e78284' })
      vim.api.nvim_set_hl(0, '@punctuation.delimiter', { fg = '#e78284' })

      vim.api.nvim_set_hl(0, '@module', { fg = '#efc176' })
      vim.api.nvim_set_hl(0, '@lsp.type.namespace', { fg = '#efc176' })

      vim.api.nvim_set_hl(0, '@lsp.type.variable', { fg = 'Red' })
      vim.api.nvim_set_hl(0, '@lsp.type.interface', { fg = '#e5c890' })
      vim.api.nvim_set_hl(0, '@lsp.type.typeParameter', { fg = '#fcc5aa' })

      vim.api.nvim_set_hl(0, '@lsp.mod.readonly', { fg = '#babbf1' })
      vim.api.nvim_set_hl(0, '@variable.parameter', { fg = '#babbf1' })
    end,
    opts = {
      term_colors = true,
      transparent_background = true,
      float = {
        transparent = true,
        solid = false,
      },
      dim_inactive = {
        enabled = false, -- dims the background color of inactive window
        shade = 'dark',
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
      },
      no_italic = true,
      no_bold = true,
      integrations = {
        notify = true,
        fidget = true,
        mini = {
          enabled = true,
          indentscope_color = '',
        },
      },
    },
  },

  -- Highlight todo, notes, etc in comments
  {
    'folke/todo-comments.nvim',
    enabled = vim.g.vscode == nil,
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    enabled = vim.g.vscode == nil,
    init = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

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

      -- now that setup ran we can use 'MiniMap' instead of 'map'
      MiniMap.open() -- open on start

      -- vim.keymap.set('n', '<leader>mc', MiniMap.close)
      -- vim.keymap.set('n', '<leader>mf', MiniMap.toggle_focus)
      -- vim.keymap.set('n', '<leader>mo', MiniMap.open)
      -- vim.keymap.set('n', '<leader>mr', MiniMap.refresh)
      -- vim.keymap.set('n', '<leader>ms', MiniMap.toggle_side)
      vim.keymap.set('n', '<leader>mt', MiniMap.toggle)

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = {
        'bash',
        'c',
        'diff',
        'gitcommit',
        'git_rebase',
        'html',
        'just',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'query',
        'scala',
        'vim',
        'vimdoc',
      },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    config = function(_, opts)
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

      -- Prefer git instead of curl in order to improve connectivity in some environments
      require('nvim-treesitter.install').prefer_git = true
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)

      -- There are additional nvim-treesitter modules that you can use to interact
      -- with nvim-treesitter. You should go explore a few and see what interests you:
      --
      --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
      --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
      --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    enabled = vim.g.vscode == nil,
    opts = {
      max_lines = 10,
      multiline_threshold = 1,
      zindex = 1,
    },
  },

  -- The following two comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  require 'kickstart.plugins.debug',
  require 'kickstart.plugins.indent_line',
  require 'kickstart.plugins.lint',
  require 'kickstart.plugins.autopairs',
  require 'kickstart.plugins.neo-tree',
  require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --    For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
  -- { import = 'custom.plugins' },
  -- add this to your lua/plugins.lua, lua/plugins/init.lua,  or the file you keep your other plugins:
  {
    'numToStr/Comment.nvim',
    enabled = vim.g.vscode == nil,
    opts = {
      toggler = {
        line = '<C-_>',
        block = '<C-S-_>', -- doesn't work for now but visually marking and then gc works
      },
      opleader = {
        line = '<C-_>',
        block = '<C-S-_>', -- doesn't work for now but visually marking and then gc works
      },
    },
  },
  { 'michaeljsmith/vim-indent-object' },
  { 'editorconfig/editorconfig-vim' },
  { 'tpope/vim-repeat' },
  { 'tpope/vim-surround' },
  { 'tpope/vim-unimpaired' },
  {
    'tveskag/nvim-blame-line',
    enabled = vim.g.vscode == nil,
  },
  { 'unblevable/quick-scope' },
  {
    'romgrk/barbar.nvim',
    enabled = vim.g.vscode == nil,
    dependencies = {
      'lewis6991/gitsigns.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    opts = {},
    version = '^1.0.0', -- optional: only update when a new 1.x version is released
  },
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    enabled = vim.g.vscode == nil,
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-vsnip' },
      { 'hrsh7th/vim-vsnip' },
    },
    opts = function()
      local cmp = require 'cmp'
      local conf = {
        sources = {
          { name = 'nvim_lsp' },
          { name = 'vsnip' },
        },
        snippet = {
          expand = function(args)
            -- Comes from vsnip
            vim.fn['vsnip#anonymous'](args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert {
          -- None of this made sense to me when first looking into this since there
          -- is no vim docs, but you can't have select = true here _unless_ you are
          -- also using the snippet stuff. So keep in mind that if you remove
          -- snippets you need to remove this select
          ['<CR>'] = cmp.mapping.confirm { select = true },
        },
      }
      return conf
    end,
  },
  {
    'scalameta/nvim-metals',
    enabled = vim.g.vscode == nil,
    dependencies = {
      { 'j-hui/fidget.nvim' },
      {
        'mfussenegger/nvim-dap',
        config = function(_, _)
          -- Debug settings if you're using nvim-dap
          local dap = require 'dap'

          dap.configurations.scala = {
            {
              type = 'scala',
              request = 'launch',
              name = 'RunOrTest',
              metals = {
                runType = 'runOrTestFile',
                --args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
              },
            },
            {
              type = 'scala',
              request = 'launch',
              name = 'Test Target',
              metals = {
                runType = 'testTarget',
              },
            },
          }
        end,
      },
    },
    ft = { 'scala', 'sbt', 'java' },
    keys = {
      {
        '<leader>cW',
        function()
          require('metals').hover_worksheet()
        end,
        desc = 'Metals Worksheet',
      },
      {
        '<leader>cM',
        function()
          require('telescope').extensions.metals.commands()
        end,
        desc = 'Telescope Metals Commands',
      },
    },
    opts = function()
      local metals_config = require('metals').bare_config()

      -- Alternative way to save
      -- vim.keymap.set('n', '<C-s>', ':update<CR>:MetalsCompileCascade<CR>', { desc = 'Save', silent = true })
      -- vim.keymap.set('v', '<C-s>', '<C-c>:update<CR>:MetalsCompileCascade<CR>gv', { desc = 'Save', silent = true })
      -- vim.keymap.set('i', '<C-s>', '<C-o>:update<CR><C-o>:MetalsCompileCascade<CR>', { desc = 'Save', silent = true })
      -- Normal and visual modes
      vim.keymap.set({ 'n', 'v' }, '<C-s>', '<Esc>:update<CR>:MetalsCompileCascade<CR>', { desc = 'Save', silent = true })

      -- Insert mode (stays in insert mode after saving)
      vim.keymap.set('i', '<C-s>', '<Esc>:update<CR>:MetalsCompileCascade<CR>a', { desc = 'Save', silent = true })

      -- Example of settings
      metals_config.settings = {
        -- serverVersion = '1.3.5',
        automaticImportBuild = 'all',
        defaultBspToBuildTool = true,
        startMcpServer = vim.g.vscode == nil,
        mcpClient = 'claude',
        showImplicitArguments = true,
        showImplicitConversionsAndClasses = true,
        showInferredType = true,
        excludedPackages = {
          'akka.actor.typed.javadsl',
          'com.github.swagger.akka.javadsl',
        },
        inlayHints = {
          byNameParameters = { enable = true },
          closingLabels = { enable = true },
          hintsInPatternMatch = { enable = true },
          hintsXRayMode = { enable = true },
          implicitArguments = { enable = true },
          implicitConversions = { enable = true },
          inferredTypes = { enable = true },
          namedParameters = { enable = true },
          typeParameters = { enable = true },
        },
        testUserInterface = 'Test Explorer',
      }

      -- *READ THIS*
      -- I *highly* recommend setting statusBarProvider to either "off" or "on"
      --
      -- "off" will enable LSP progress notifications by Metals and you'll need
      -- to ensure you have a plugin like fidget.nvim installed to handle them.
      --
      -- "on" will enable the custom Metals status extension and you *have* to have
      -- a have settings to capture this in your statusline or else you'll not see
      -- any messages from metals. There is more info in the help docs about this
      metals_config.init_options.statusBarProvider = 'off'

      -- Example if you are using cmp how to make sure the correct capabilities for snippets are set
      metals_config.capabilities = require('cmp_nvim_lsp').default_capabilities()

      metals_config.on_attach = function(client, bufnr)
        require('metals').setup_dap()
      end

      return metals_config
    end,
    config = function(self, metals_config)
      local nvim_metals_group = vim.api.nvim_create_augroup('nvim-metals', { clear = true })
      vim.api.nvim_create_autocmd('FileType', {
        pattern = self.ft,
        callback = function()
          vim.schedule(function()
            require('metals').initialize_or_attach(metals_config)
          end)
        end,
        group = nvim_metals_group,
      })
    end,
  },
  { 'github/copilot.vim' },
  {
    'lukas-reineke/virt-column.nvim',
    enabled = vim.g.vscode == nil,
    opts = {
      char = '│',
      virtcolumn = '100',
      highlight = 'LineNr',
    },
  },
  {
    'Bekaboo/dropbar.nvim',
    enabled = vim.g.vscode == nil,
    dependencies = {
      'nvim-telescope/telescope-fzf-native.nvim',
    },
  },
  -- {
  --   'rcarriga/nvim-notify',
  --   enabled = vim.g.vscode == nil,
  --   opts = {
  --     fps = 120,
  --     stages = 'slide',
  --   },
  -- },
  {
    'folke/snacks.nvim',
    enabled = vim.g.vscode == nil,
    priority = 1000,
    lazy = false,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      bigfile = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
    },
  },
  {
    'folke/trouble.nvim',
    enabled = vim.g.vscode == nil,
    opts = {
      warn_no_results = false,
    }, -- for default options, refer to the configuration section for custom setup.
    cmd = 'Trouble',
    keys = {
      {
        '<leader>xx',
        '<cmd>Trouble diagnostics toggle<cr>',
        desc = 'Diagnostics (Trouble)',
      },
      {
        '<leader>xX',
        '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
        desc = 'Buffer Diagnostics (Trouble)',
      },
      {
        '<leader>cs',
        '<cmd>Trouble symbols toggle focus=false<cr>',
        desc = 'Symbols (Trouble)',
      },
      {
        '<leader>cl',
        '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
        desc = 'LSP Definitions / references / ... (Trouble)',
      },
      {
        '<leader>xL',
        '<cmd>Trouble loclist toggle<cr>',
        desc = 'Location List (Trouble)',
      },
      {
        '<leader>xQ',
        '<cmd>Trouble qflist toggle<cr>',
        desc = 'Quickfix List (Trouble)',
      },
    },
  },
  {
    'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
    enabled = vim.g.vscode == nil,
    opts = {
      highlight_whole_line = false, -- this doesn't work for some reason
    },
    init = function()
      vim.wo.signcolumn = 'yes'
      vim.diagnostic.config {
        virtual_text = false,
        virtual_lines = { highlight_whole_line = false }, -- this doesn't work for some reason
      }
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    enabled = vim.g.vscode == nil,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {},
  },
  {
    'norcalli/nvim-colorizer.lua',
    enabled = vim.g.vscode == nil,
    opts = {},
    config = function()
      require('colorizer').setup()
    end,
  },
  {
    'ravitemer/mcphub.nvim',
    enabled = vim.g.vscode == nil,
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    build = 'npm install -g mcp-hub@latest',
    config = function()
      require('mcphub').setup()
    end,
  },
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

if vim.g.vscode then
else
end

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
