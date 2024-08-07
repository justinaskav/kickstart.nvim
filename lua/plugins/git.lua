return {
  {
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set('n', '<leader>gd', ':Gdiff<CR>', { desc = '[G]it [D]iff' })
      vim.keymap.set('n', '<leader>gl', ':Glog<CR>', { desc = '[G]it [L]og' })
    end,
  },
  'tpope/vim-rhubarb',

  -- Adds git related signs to the gutter, as well as utilities for managing changes
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        -- vim.keymap.set('n', '<leader>gp', require('gitsigns').preview_hunk,
        --   { buffer = bufnr, desc = '[G]it Hunk [P]review' })

        -- don't override the built-in and fugitive keymaps
        -- local gs = package.loaded.gitsigns
        -- vim.keymap.set({ 'n', 'v' }, ']c', function()
        --   if vim.wo.diff then
        --     return ']c'
        --   end
        --   vim.schedule(function()
        --     gs.next_hunk()
        --   end)
        --   return '<Ignore>'
        -- end, { expr = true, buffer = bufnr, desc = 'Jump to next hunk' })
        -- vim.keymap.set({ 'n', 'v' }, '[c', function()
        --   if vim.wo.diff then
        --     return '[c'
        --   end
        --   vim.schedule(function()
        --     gs.prev_hunk()
        --   end)
        --   return '<Ignore>'
        -- end, { expr = true, buffer = bufnr, desc = 'Jump to previous hunk' })
      end,
    },
  },
  { 'akinsho/git-conflict.nvim', version = "*", config = true }
}
