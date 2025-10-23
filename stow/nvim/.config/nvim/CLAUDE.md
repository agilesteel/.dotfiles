# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Neovim configuration based on Kickstart.nvim, customized with additional plugins and settings. The configuration is managed using GNU Stow from a dotfiles repository and uses lazy.nvim for plugin management.

## Project Structure

- `init.lua` - Main configuration file containing settings, keymaps, and autocommands. Plugin setup is minimal - just requires from lua/kickstart/plugins/
- `lua/kickstart/plugins/` - All plugin configurations are modularized here:
  - Core plugins: `vim-sleuth.lua`, `which-key.lua`, `telescope.lua`, `lspconfig.lua`, `conform.lua`, `cmp.lua`
  - UI plugins: `catppuccin.lua`, `todo-comments.lua`, `mini.lua`, `treesitter.lua`, `ui.lua`
  - Functionality: `comment.lua`, `simple-plugins.lua`, `barbar.lua`
  - Language-specific: `nvim-metals.lua`
  - Optional: `debug.lua`, `indent_line.lua`, `lint.lua`, `autopairs.lua`, `neo-tree.lua`, `gitsigns.lua`
  - Integrations: `mcphub.lua`
- `lua/custom/` - Directory for custom user plugins (currently empty)
- `.stylua.toml` - Formatting configuration for Lua code

## Key Architecture Details

### Plugin Management

The configuration uses lazy.nvim as the plugin manager. All plugins are modularized into separate files in `lua/kickstart/plugins/`. The main `init.lua` file (line 285) simply requires all plugin files:

```lua
require('lazy').setup({
  require 'kickstart.plugins.vim-sleuth',
  require 'kickstart.plugins.telescope',
  -- ... etc
})
```

Each plugin file returns a table (or array of tables) with plugin specifications. This modular approach makes it easy to:
- Enable/disable plugins by commenting out a single line in init.lua
- Find and edit plugin configurations in dedicated files
- Organize plugins by category (core, UI, language-specific, etc.)

### LSP Configuration

LSP setup is in `lua/kickstart/plugins/lspconfig.lua`:
- Mason (`mason.nvim`) automatically installs language servers
- `mason-lspconfig` bridges Mason and lspconfig
- LSP keybindings are defined in the `LspAttach` autocommand
- Currently configured LSPs: `lua_ls`
- All LSP keymaps and handlers are centralized in this one file

### Scala Development

Scala support is in `lua/kickstart/plugins/nvim-metals.lua`:
- Metals LSP for Scala/sbt/Java
- DAP (Debug Adapter Protocol) integration configured
- Custom save behavior triggers `MetalsCompileCascade` on Ctrl-S
- Metals settings include inlay hints, test explorer UI, and MCP server support
- Separate nvim-cmp configuration for vsnip integration (used by Metals)

### VSCode Compatibility

Many plugins check `vim.g.vscode` to disable themselves when running as VSCode Neovim extension, allowing this config to work in both environments.

## Common Commands

### Plugin Management
```
:Lazy                  # Open lazy.nvim plugin manager UI
:Lazy update           # Update all plugins
:Mason                 # Open Mason LSP installer UI
:checkhealth           # Check Neovim health (useful for troubleshooting)
```

### Formatting
```
stylua .               # Format Lua files according to .stylua.toml
```

### LSP & Diagnostics
```
:Trouble diagnostics   # Open diagnostics viewer
:MetalsCompileCascade  # Compile Scala project (triggered on save for Scala files)
```

## Important Keybindings

### Custom Leader Key
- Leader key: `<Space>`
- Local leader: `<Space>`

### Navigation
- `<C-h/j/k/l>` - Window navigation
- `<M-h/j/k/l>` - Resize windows
- `<C-PageDown/PageUp>` - Buffer navigation
- `jk` (insert mode) - Exit to normal mode

### File Operations
- `<C-s>` - Save file (works in normal, visual, and insert modes)
- `<C-p>` or `<leader>sf` - Find files (Telescope)
- `<leader>sg` - Live grep
- `<leader>w` - Close buffer

### LSP
- `gd` - Go to definition (Telescope)
- `gr` - Go to references (Telescope)
- `gi` - Go to implementation (Telescope, excludes tests by default)
- `gti` - Go to implementation (includes tests)
- `K` - Hover documentation
- `<leader>rn` - Rename symbol
- `<leader>ca` - Code action
- `<leader>f` - Format buffer

### Diagnostics
- `<leader>aa` - All workspace diagnostics
- `<leader>ae` - All workspace errors
- `<leader>aw` - All workspace warnings
- `<leader>[c` / `<leader>]c` - Navigate diagnostics with Trouble

### Scala-Specific
- `gs` - Go to super method (Metals)
- `<leader>ws` - Hover worksheet
- `<C-s>` - Save and compile cascade (Scala files only)

## Configuration Style

- Uses Catppuccin-frappe colorscheme with transparent background (configured in `lua/kickstart/plugins/catppuccin.lua`)
- Extensive custom highlight groups for syntax
- Relative line numbers that toggle off in insert mode (autocommands in init.lua)
- 2-space indentation for all files
- Vertical telescope layout
- Comment continuation disabled on new lines
- Mini.nvim minimap enabled by default

## Adding New Plugins

To add a new plugin:
1. Create a new file in `lua/kickstart/plugins/` (e.g., `my-plugin.lua`)
2. Return a plugin specification table from that file
3. Add `require 'kickstart.plugins.my-plugin',` to the lazy.setup() call in init.lua
4. Restart Neovim or run `:Lazy sync`
