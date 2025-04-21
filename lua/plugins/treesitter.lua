return {
  -- Highlight, edit, and navigate code
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
    dev = false,
    config = function()
      -- [[ Configure Treesitter ]]
      vim.filetype.add({
        pattern = {
          [".*%.blade%.php"] = "blade",
        },
      })

      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.blade = {
        install_info = {
          url = "https://github.com/EmranMR/tree-sitter-blade",
          files = { "src/parser.c" },
          branch = "main",
        },
        filetype = "blade",
      }

      -- See `:help nvim-treesitter`
      -- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
      vim.defer_fn(function()
        ---@diagnostic disable-next-line missing-fields
        require('nvim-treesitter.configs').setup {
          -- Add languages to be installed here that you want installed for treesitter
          ensure_installed = { 'blade', 'php_only', 'lua', 'python', 'rust', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim', 'bash', 'vue', 'json', 'r', 'markdown', 'markdown_inline', 'yaml', 'query', 'html', 'css', 'astro', 'php', 'phpdoc', 'csv', 'tsv', 'mermaid', 'typst', 'rust' },
          auto_install = false,
          highlight = { enable = true, additional_vim_regex_highlighting = false },
          indent = { enable = true },
          textobjects = {
            select = {
              enable = true,
              lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
              keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ['aa'] = '@parameter.outer',
                ['ia'] = '@parameter.inner',
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
              },
            },
            incremental_selection = {
              enable = true,
              -- keymaps = {
              --   init_selection = 'gnn',
              --   node_incremental = 'grn',
              --   scope_incremental = 'grc',
              --   node_decremental = 'grm',
              -- },
            },
            move = {
              enable = true,
              set_jumps = true, -- whether to set jumps in the jumplist
              goto_next_start = {
                [']m'] = '@function.outer',
                [']]'] = '@class.outer',
              },
              goto_next_end = {
                [']M'] = '@function.outer',
                [']['] = '@class.outer',
              },
              goto_previous_start = {
                ['[m'] = '@function.outer',
                ['[['] = '@class.outer',
              },
              goto_previous_end = {
                ['[M'] = '@function.outer',
                ['[]'] = '@class.outer',
              },
            },
            --[[ swap = {
            enable = true,
            swap_next = {
              ['<leader>a'] = '@parameter.inner',
            },
            swap_previous = {
              ['<leader>A'] = '@parameter.inner',
            },
          }, ]]
          },
        }
      end, 0)
    end
  },
  -- Comment strings in multilanguage files (e.g. vue)
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    ft = { 'vue' },
    config = function()
      require('ts_context_commentstring').setup {
        enable_autocmd = false,
      }

      -- Native commenting as in https://github.com/JoosepAlviste/nvim-ts-context-commentstring/wiki/Integrations#native-commenting-in-neovim-010
      local get_option = vim.filetype.get_option
      vim.filetype.get_option = function(filetype, option)
        return option == "commentstring"
            and require("ts_context_commentstring.internal").calculate_commentstring()
            or get_option(filetype, option)
      end
    end
  },
  {
    'HiPhish/rainbow-delimiters.nvim',
    -- TODO: Need to figure out how to get this to work with treesitter
    enabled = false,
    config = function()
      local rainbow_delimiters = require 'rainbow-delimiters'

      vim.g.rainbow_delimiters = {
        strategy = {
          [''] = rainbow_delimiters.strategy['noop'],
          csv = rainbow_delimiters.strategy['global'],
          tsv = rainbow_delimiters.strategy['global']
        },
      }
    end
  }
}
