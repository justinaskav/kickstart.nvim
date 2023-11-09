return {
  -- Detect tabstop and shiftwidth automatically
  {
    'tpope/vim-sleuth',
    config = function()
      vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = 'Show [U]ndo Tree' })
    end
  },
  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    opts = {},
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },
  'mbbill/undotree'
}
