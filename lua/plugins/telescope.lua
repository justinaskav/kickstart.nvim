-- Fuzzy Finder (files, lsp, etc)

return {
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      -- {
      --   'jmbuhr/telescope-zotero.nvim',
      --   enabled = true,
      --   dev = false,
      --   dependencies = {
      --     { 'kkharji/sqlite.lua' },
      --   },
      --   config = function()
      --     vim.keymap.set('n', '<leader>fz', ':Telescope zotero<cr>', { desc = '[z]otero' })
      --   end,
      -- },
    },
    config = function()
      require("config.plugins.telescope")
    end
  },
  -- {
  --   "nvim-telescope/telescope-frecency.nvim",
  --   config = function()
  --     require("telescope").load_extension "frecency"
  --
  --     vim.keymap.set("n", "<leader>.", "<Cmd>Telescope frecency workspace=CWD<CR>",
  --       { desc = '[.] Find most opened files' })
  --   end,
  -- },
}
