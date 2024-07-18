return {
  -- LSP Configuration & Plugins
  'neovim/nvim-lspconfig',
  tag = nil,
  version = nil,
  branch = "master",
  event = "BufReadPre",
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
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

    -- Additional lua configuration, makes nvim stuff amazing!
    'folke/neodev.nvim',
    {
      "microsoft/python-type-stubs",
      cond = false
    },
  },
  config = function()
    -- mason-lspconfig requires that these setup functions are called in this order
    -- before setting up the servers.
    require('mason').setup()
    require('mason-lspconfig').setup()

    require('mason-tool-installer').setup {
      ensure_installed = {
        'black',
        'stylua',
        'shfmt',
        'isort',
        'tree-sitter-cli',
      },
    }

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

      nmap('<leader>dr', vim.lsp.buf.rename, '[R]ename')
      nmap('<leader>da', vim.lsp.buf.code_action, 'Code [A]ction')

      nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
      nmap('<leader>dr', require('telescope.builtin').lsp_references, 'Go To [R]eferences')
      nmap('<leader>dI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
      nmap('<leader>dd', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
      -- nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, 'Document [S]ymbols')
      vim.keymap.set('n', '<leader>dq', function() require("trouble").toggle("quickfix") end,
        { desc = 'Trouble: Open [Q]uickfix' })
      vim.keymap.set('n', '<leader>dl', function() require("trouble").toggle("workspace_diagnostics") end,
        { desc = 'Trouble: Open [L]ist of diagnostics' })
      -- No need for document symbols
      -- nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

      -- See `:help K` for why this keymap
      nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
      nmap('<leader>dk', vim.lsp.buf.signature_help, 'Signature Documentation')

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

    -- Enable the following language servers
    --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
    --
    --  Add any additional override configuration in the following tables. They will be passed to
    --  the `settings` field of the server config. You must look up that documentation yourself.
    --
    --  If you want to override the default filetypes that your language server will attach to you can
    --  define the property 'filetypes' to the map in question.
    local lua_plugin_paths = {}

    local util = require("lspconfig.util")

    local servers = {
      astro = { filetypes = { 'astro' } },
      bashls = {
        filetypes = { 'sh', 'bash', 'zsh' }
      },
      cssls = { filetypes = { 'css', 'scss', 'less', 'sass' } },
      eslint = {},
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
      jsonls = {},
      julials = {},
      lua_ls = {
        Lua = {
          completion = {
            callSnippet = "Replace",
          },
          runtime = {
            version = "LuaJIT",
            plugin = lua_plugin_paths,
          },
          diagnostics = {
            globals = { "vim", "quarto", "pandoc", "io", "string", "print", "require", "table" },
            disable = { "trailing-space" },
          },
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
        },
      },
      -- also needs:
      -- $home/.config/marksman/config.toml :
      -- [core]
      -- markdown.file_extensions = ["md", "markdown", "qmd"]
      marksman = {
        filetypes = { 'markdown', 'quarto' },
        -- root_dir = util.root_pattern('.git', '.marksman.toml', '_quarto.yml'),
      },
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
      tailwindcss = {},
      typst_lsp = {},
      -- Volar instead of tsserver
      volar = { filetypes = { 'vue', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' }, init_options = { vue = { hybridMode = false } } },
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
    require('neodev').setup()

    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    -- Ensure the servers above are installed
    local mason_lspconfig = require 'mason-lspconfig'
    mason_lspconfig.setup {
      ensure_installed = vim.tbl_keys(servers),
    }

    mason_lspconfig.setup_handlers {
      function(server_name)
        require('lspconfig')[server_name].setup {
          capabilities = capabilities,
          on_attach = on_attach,
          flags = lsp_flags,
          settings = servers[server_name],
          filetypes = (servers[server_name] or {}).filetypes,
          init_options = (servers[server_name] or {}).init_options,
          root_dir = (servers[server_name] or {}).root_dir,
        }
      end,
    }

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
