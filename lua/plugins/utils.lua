return {
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',
  -- "gc" to comment visual regions/lines
  'numToStr/Comment.nvim',
  {
    -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = "VeryLazy",
    opts = {}
  },
  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',

    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    opts = {},
  },
  {
    -- UndoTree shows the undo history and allows you to switch to a previous state
    'mbbill/undotree',
    -- Enable on keypress
    keys = {
      { "<leader>vu", ":UndotreeToggle<CR>", noremap = true, desc = "Toggle [U]ndo Tree" },
    }
  }
}
