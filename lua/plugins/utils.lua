return {
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',
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
  {
    "chrishrb/gx.nvim",
    event = "BufEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true,
  },
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
    event = "BufEnter",
    config = function()
      local trouble = require("trouble")
      trouble.setup({})

      -- Sometimes we need to close Trouble without LSP
      vim.keymap.set('n', '<leader>vt', function() trouble.toggle() end, { desc = 'Toggle [T]rouble' })
    end
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
      { "nvim-neotest/nvim-nio" }
    },
    config = function()
      require('neotest').setup({
        -- ...,
        adapters = {
          require('neotest-pest'),
        }
      })

      -- set keys
      vim.keymap.set("n", "<leader>lt", function () require("neotest").run.run() end, { desc = '[T]est with Laravel Pest (Neotest)' })
      vim.keymap.set("n", "<leader>lo", function () require("neotest").output.open({ enter = true }) end, { desc = '[O]pen output with Laravel Pest (Neotest)' })
    end
  }
  -- {
  --   "luckasRanarison/tailwind-tools.nvim",
  --   opts = {} -- your configuration
  -- }
}
