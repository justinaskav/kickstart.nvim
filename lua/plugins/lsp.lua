return {
    {
      'j-hui/fidget.nvim',
      tag = "v1.1.0",
      opts = {
        notification = {
          window = {
            winblend = 80,
          },
        }
      }
    },
    {
  -- LSP Configuration & Plugins
  -- NOTE: keep for the utilities
  'neovim/nvim-lspconfig',
  enabled = false,
  tag = nil,
  version = nil,
  branch = "master",
  event = "BufReadPre",
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    -- "hrsh7th/cmp-nvim-lsp",
    { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
    -- Useful status updates for LSP
    -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
    {
      'j-hui/fidget.nvim',
      tag = "v1.1.0",
      opts = {
        notification = {
          window = {
            winblend = 80,
          },
        }
      }
    },
    {
      "microsoft/python-type-stubs",
      cond = false
    },
  },
  config = function()
    -- mason-lspconfig requires that these setup functions are called in this order
    -- before setting up the servers.

    -- [[ Configure LSP ]]
    --  This function gets run when an LSP connects to a particular buffer.
    local on_attach = function(_, bufnr)
      -- NOTE: Remember that lua is a real programming language, and as such it is possible
      -- to define small helper and utility functions so you don't have to repeat yourself
      -- many times.
      --
      -- In this case, we create a function that lets us more easily define mappings specific
      -- for LSP related items. It sets the mode, buffer and description for us each time.
      local nmap = function(keys, func, desc)
        if desc then
          desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
      end

      -- nmap('<leader>dc', vim.lsp.buf.rename, '[R]ename')
      -- nmap('<leader>da', vim.lsp.buf.code_action, 'Code [A]ction')
      --
      -- nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
      -- nmap('<leader>dr', require('telescope.builtin').lsp_references, 'Go To [R]eferences')
      -- nmap('<leader>dI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
      -- nmap('<leader>dd', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
      -- nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, 'Document [S]ymbols')
      -- vim.keymap.set('n', '<leader>dq', function() require("trouble").toggle("quickfix") end,
      --   { desc = 'Trouble: Open [Q]uickfix' })
      -- vim.keymap.set('n', '<leader>dl', function() require("trouble").toggle("workspace_diagnostics") end,
      --   { desc = 'Trouble: Open [L]ist of diagnostics' })
      -- No need for document symbols
      -- nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

      -- See `:help K` for why this keymap
      -- nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
      -- nmap('<leader>dk', vim.lsp.buf.signature_help, 'Signature Documentation')

      -- Lesser used LSP functionality
      -- nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
      -- nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
      -- nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
      -- nmap('<leader>wl', function()
      --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      -- end, '[W]orkspace [L]ist Folders')

      -- Create a command `:LspFormat` local to the LSP buffer
      vim.api.nvim_buf_create_user_command(bufnr, 'LspFormat', function(_)
        vim.lsp.buf.format()
      end, { desc = 'Format current buffer with LSP' })

      -- require("which-key").register({
      --   ['d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
      -- }, { prefix = '<leader>' })
      require("which-key").add({ '<leader>d', { group = '[D]ocument' } })
    end

    local lsp_flags = {
      allow_incremental_sync = true,
      debounce_text_changes = 150,
    }

    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

    local servers = {
      astro = { filetypes = { 'astro' } },
      bashls = {
        filetypes = { 'sh', 'bash', 'zsh' }
      },
      -- harper_ls = {
      --   settings = {
      --     linters = {
      --       SentenceCapitalization = false,
      --       SpellCheck = false
      --     }
      --   }
      -- },
      html = { filetypes = { 'html', 'twig', 'hbs' } },
      intelephense = {
        -- Instead of HOME, put intelephense folder in XDG_DATA_HOME
        init_options = {
          globalStoragePath = os.getenv('HOME') .. '/.local/share/intelephense'
        }
      },
      jedi_language_server = {
        python = {
          analysis = {
            autoSearchPaths = true,
            useLibraryCodeForTypes = false,
            diagnosticMode = "openFilesOnly"
          }
        }
      },
      julials = {},
      -- pyright = {
      --   python = {
      --     stubPath = vim.fn.stdpath("data") .. "/lazy/python-type-stubs",
      --     analysis = {
      --       autoSearchPaths = true,
      --       useLibraryCodeForTypes = false,
      --       diagnosticMode = "openFilesOnly",
      --     },
      --   },
      --   root_dir = function(fname)
      --     return util.root_pattern(".git", "setup.py", "setup.cfg", "pyproject.toml", "requirements.txt")(
      --       fname
      --     ) or util.path.dirname(fname)
      --   end,
      -- },
      r_language_server = {
        lsp = {
          rich_documentation = false,
        }
      },
      rust_analyzer = {
        filetypes = { 'rust' },
        settings = {
          ["rust-analyzer"] = {
            checkOnSave = {
              command = "clippy",
            },
            cargo = {
              loadOutDirsFromCheck = true,
            },
            procMacro = {
              enable = true,
            },
          },
        },
      },
      tailwindcss = {},
      tinymist = {},
      yamlls = {
        yaml = {
          schemas = {
            -- add custom schemas here
            ['http://json.schemastore.org/github-workflow'] = '.github/workflows/*.{yml,yaml}',
            ['http://json.schemastore.org/github-action'] = '.github/action.{yml,yaml}',
          },
          schemaStore = {
            enable = true,
            url = ""
          }
        }
      },
    }

    -- Setup neovim lua configuration
    require('lazydev').setup()

    -- Ensure the servers above are installed
    local ensure_installed = vim.tbl_keys(servers or {})

    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    require('mason-lspconfig').setup({
      ensure_installed = ensure_installed,
      automatic_installation = false,
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          -- This handles overriding only values explicitly passed
          -- by the server configuration above. Useful when disabling
          -- certain features of an LSP (for example, turning off formatting for ts_ls)
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          server.on_attach = on_attach
          server.flags = lsp_flags
          -- server.settings = servers[server_name]
          -- server.filetypes = (servers[server_name] or {}).filetypes
          -- init_options = (servers[server_name] or {}).init_options
          -- root_dir = (servers[server_name] or {}).root_dir

          require('lspconfig')[server_name].setup(server)
        end,
      }
    })

    -- local lspconfig = require('lspconfig')
    --
    -- -- See https://github.com/neovim/neovim/issues/23291
    -- -- disable lsp watcher.
    -- -- Too lags on linux for python projects
    -- -- because pyright and nvim both create too many watchers otherwise
    -- if capabilities.workspace == nil then
    --   capabilities.workspace = {}
    --   capabilities.workspace.didChangeWatchedFiles = {}
    -- end
    -- capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false
    --
    -- lspconfig.pyright.setup {
    --   capabilities = capabilities,
    --   flags = lsp_flags,
    --   settings = {
    --     python = {
    --       analysis = {
    --         autoSearchPaths = true,
    --         useLibraryCodeForTypes = true,
    --         diagnosticMode = 'workspace',
    --       },
    --     },
    --   },
    --   root_dir = function(fname)
    --     return util.root_pattern('.git', 'setup.py', 'setup.cfg', 'pyproject.toml', 'requirements.txt')(fname) or
    --         util.path.dirname(fname)
    --   end,
    -- }
    --

    require('config.autoformat')
  end
}
}
