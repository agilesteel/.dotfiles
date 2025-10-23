-- LSP Configuration & Plugins
return {
  {
    'neovim/nvim-lspconfig',
    enabled = vim.g.vscode == nil,
    dependencies = {
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      {
        'j-hui/fidget.nvim',
        opts = {
          notification = {
            view = {
              line_margin = 0,
            },
            window = {
              winblend = 0, -- Transparent background
              x_padding = 0,
            },
          },
          progress = {
            ignore_done_already = true,
            ignore_empty_message = true,
            display = {
              done_ttl = 1,
              render_limit = 100,
              format_message = function(msg)
                return msg.message
              end,
            },
          },
        },
      },
      {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
          library = {
            { path = 'luvit-meta/library', words = { 'vim%.uv' } },
          },
        },
      },
      { 'Bilal2453/luvit-meta', lazy = true },
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('gd', function()
            require('telescope.builtin').lsp_definitions {
              show_line = false,
            }
          end, '[G]oto [D]efinition')

          map('gs', function()
            require('metals').goto_super_method()
          end, '[G]oto [S]uper Method')

          map('gr', function()
            require('telescope.builtin').lsp_references {
              show_line = false,
              include_declaration = false,
            }
          end, '[G]oto [R]eferences')

          map('gi', function()
            require('telescope.builtin').lsp_implementations { show_line = false, default_text = '!test ' }
          end, '[G]oto [I]mplementation')

          map('gti', function()
            require('telescope.builtin').lsp_implementations { show_line = false }
          end, '[G]oto [I]mplementation')

          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          vim.keymap.set('n', 'K', vim.lsp.buf.hover)
          vim.keymap.set('n', 'gds', vim.lsp.buf.document_symbol)
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

          vim.keymap.set('n', '<leader>aa', vim.diagnostic.setqflist)

          map('<leader>ae', function()
            require('telescope.builtin').diagnostics { severity = vim.diagnostic.severity.ERROR }
          end, '[A]ll [E]rrors')

          map('<leader>aw', function()
            require('telescope.builtin').diagnostics { severity = vim.diagnostic.severity.WARN }
          end, '[A]ll [W]arnings')

          vim.keymap.set('n', '<leader>d', vim.diagnostic.setloclist)
          vim.keymap.set('n', '<leader>[c', function()
            require('trouble').prev { mode = 'diagnostics' }
            require('trouble').jump_close { mode = 'diagnostics' }
          end)

          vim.keymap.set('n', '<leader>]c', function()
            require('trouble').next { mode = 'diagnostics' }
            require('trouble').jump_close { mode = 'diagnostics' }
          end)

          -- DAP keymaps
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

          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              diagnostics = {
                globals = { 'vim' },
              },
              workspace = {
                checkThirdParty = false,
              },
            },
          },
        },
      }

      require('mason').setup()

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua',
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
}
