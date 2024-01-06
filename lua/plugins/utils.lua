return {
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',
  -- "gc" to comment visual regions/lines
  {
    'numToStr/Comment.nvim',
    lazy = false,
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring'
    },
    config = function()
      require('Comment').setup({
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()
      })
    end
  },
  {
    -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = "VeryLazy",
    config = true
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
    event = { "BufEnter" },
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
    config = function()
      local trouble = require("trouble")
      trouble.setup({})

      -- Sometimes we need to close Trouble without LSP
      vim.keymap.set('n', '<leader>vt', function() trouble.toggle() end, { desc = 'Toggle [T]rouble' })
    end
  }
}
