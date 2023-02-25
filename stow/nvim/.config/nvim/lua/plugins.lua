local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  -- execute 'packadd packer.nvim'
end

return require('packer').startup(function()
  use({ "catppuccin/nvim", as = "catppuccin" })
  use({ "michaeljsmith/vim-indent-object" })
  use({ "glepnir/galaxyline.nvim" })
  -- use({ "joshdick/onedark.vim" })
  -- use({ "junegunn/goyo.vim", opt = true })
  use({ "hrsh7th/nvim-compe", requires = { { "hrsh7th/vim-vsnip" } } })
  -- use({
  --   "iamcco/markdown-preview.nvim",
  --   run = "cd app && yarn install",
  --   cmd = "MarkdownPreview",
  -- })
  use({ "kevinhwang91/nvim-bqf" })
  use({ "kyazdani42/nvim-tree.lua" })
  use({ "kyazdani42/nvim-web-devicons" })
  use({ "liuchengxu/vista.vim" })
  use({ "machakann/vim-sandwich" })
  use({ "mfussenegger/nvim-dap" })
  use({ "neovim/nvim-lspconfig" })
  use({ "norcalli/nvim-colorizer.lua" })
  use({
    "nvim-telescope/telescope.nvim",
    requires = {
      { "nvim-lua/popup.nvim" },
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-fzy-native.nvim" },
    },
  })
  use({ "nvim-treesitter/nvim-treesitter" })
  use({ "nvim-treesitter/playground" })
  use({ "scalameta/nvim-metals" })
  use({ "sheerun/vim-polyglot" })
  -- use({ "tpope/vim-fugitive" })
  use({ "tpope/vim-vinegar" })
  -- use({ "wakatime/vim-wakatime" })
  use({ "wbthomason/packer.nvim" })
  use({ "windwp/nvim-autopairs" })
  -- use({ "wlangstroth/vim-racket" })
  -- use({ "Yggdroot/indentLine" })

  use({ 'airblade/vim-gitgutter' })
  use({ 'editorconfig/editorconfig-vim' })
  use({ 'preservim/nerdcommenter' })
  -- use({ 'sonph/onehalf', rtp = { { "vim" } } })
  use({ 'tpope/vim-repeat' })
  use({ 'tpope/vim-surround' })
  use({ 'tpope/vim-unimpaired' })
  use({ 'tveskag/nvim-blame-line' })
  use({ 'unblevable/quick-scope' })
end)
