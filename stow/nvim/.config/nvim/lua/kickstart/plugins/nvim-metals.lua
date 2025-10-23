-- Scala LSP support
return {
  {
    'scalameta/nvim-metals',
    enabled = vim.g.vscode == nil,
    dependencies = {
      { 'j-hui/fidget.nvim' },
      {
        'mfussenegger/nvim-dap',
        config = function(_, _)
          local dap = require 'dap'

          dap.configurations.scala = {
            {
              type = 'scala',
              request = 'launch',
              name = 'RunOrTest',
              metals = {
                runType = 'runOrTestFile',
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

      -- Custom save behavior for Scala files
      vim.keymap.set({ 'n', 'v' }, '<C-s>', '<Esc>:update<CR>:MetalsCompileCascade<CR>', { desc = 'Save', silent = true })
      vim.keymap.set('i', '<C-s>', '<Esc>:update<CR>:MetalsCompileCascade<CR>a', { desc = 'Save', silent = true })

      metals_config.settings = {
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

      metals_config.init_options.statusBarProvider = 'off'
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
            vim.fn['vsnip#anonymous'](args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert {
          ['<CR>'] = cmp.mapping.confirm { select = true },
        },
      }
      return conf
    end,
  },
}
