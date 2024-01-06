return {
  -- "nvim-tree/nvim-web-devicons",
  -- {
  --   "nvim-tree/nvim-tree.lua",
  --   version = "*",
  --   lazy = false,
  --   opts = {
  --     update_focused_file = {
  --       enable = true
  --     }
  --   },
  --   keys = {
  --     { "<leader>vt", ":NvimTreeToggle<CR>", noremap = true, silent = true, desc = "Toggle File [T]ree" },
  --   },
  -- },
  {
    "simrat39/symbols-outline.nvim",
    keys = {
      { "<leader>vo", ":SymbolsOutline<CR>", desc = "Toggle Symbols [O]utline" },
    },
    config = true
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      options = {
        theme = 'tokyonight',
        component_separators = '|',
        section_separators = '',
      },
    },
  },
}
