return {
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',
  { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
  'b0o/schemastore.nvim',
  { 'williamboman/mason.nvim',                  opts = {} },
  -- Add a bottom right loading notification
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
    -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = "VeryLazy",
    config = true
  },
  { -- Highlight todo, notes, etc in comments
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },
  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    config = true
  },
  {
    -- UndoTree shows the undo history and allows you to switch to a previous state
    'mbbill/undotree',
    keys = {
      { "<leader>vu", ":UndotreeToggle<CR>", noremap = true, desc = "Toggle [U]ndo Tree" },
    }
  },
  -- {
  --   "chrishrb/gx.nvim",
  --   event = "BufEnter",
  --   dependencies = { "nvim-lua/plenary.nvim" },
  --   config = true,
  -- },
  {
    -- Terminal in Neovim
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      open_mapping = [[<c-\>]]
    }
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
  {
    "epwalsh/pomo.nvim",
    version = "*", -- Recommended, use latest release instead of latest commit
    lazy = true,
    cmd = { "TimerStart", "TimerRepeat" },
    opts = {
      -- See below for full list of options 👇
    },
  },
  {
    "danymat/neogen",
    keys = {
      { "<leader>vn", ":lua require('neogen').generate()<CR>", noremap = true, desc = "Generate [N]eogen" },
    },
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      require('neogen').setup {
        snippet_engine = 'luasnip'
      }
    end,
    -- Uncomment next line if you want to follow only stable versions
    version = "*"
  },
  {
    'mhartington/formatter.nvim',
    config = function()
      require('formatter').setup({
        filetype = {
          -- Add pint formatter
          php = {
            function()
              return {
                exe = "pint",
                stdin = false,
                ignore_exitcode = true,
              }
            end
          }
        }
      })
    end
  },
  {
    'nvim-neotest/neotest',
    dependencies = {
      -- ...,
      'V13Axel/neotest-pest',
      "marilari88/neotest-vitest",
      { "nvim-neotest/nvim-nio" }
    },
    config = function()
      require('neotest').setup({
        -- ...,
        adapters = {
          require('neotest-pest'),
          require('neotest-vitest'),
        }
      })

      -- set keys
      vim.keymap.set("n", "<leader>lt", function() require("neotest").run.run() end,
        { desc = '[T]est with Laravel Pest (Neotest)' })
      vim.keymap.set("n", "<leader>lo", function() require("neotest").output.open({ enter = true }) end,
        { desc = '[O]pen output with Laravel Pest (Neotest)' })
    end
  },
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    'chomosuke/typst-preview.nvim',
    ft = 'typst',
    version = '1.2.*',
    opts = {
      dependencies_bin = { ['tinymist'] = 'tinymist' }
    }, -- lazy.nvim will implicitly calls `setup {}`
  }
  -- {
  --   "luckasRanarison/tailwind-tools.nvim",
  --   opts = {} -- your configuration
  -- }
}
