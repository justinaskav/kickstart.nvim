return {
  "nvim-tree/nvim-web-devicons",
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    opts = {
      update_focused_file = {
        enable = true
      }
    },
    keys = {
      { "<leader>vt", ":NvimTreeToggle<CR>", noremap = true, silent = true, desc = "Toggle File [T]ree" },
    },
  },
  {
    "simrat39/symbols-outline.nvim",
    keys = {
      { "<leader>lo", ":SymbolsOutline<CR>", desc = "Symbols Outline" },
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
        theme = 'onedark',
        component_separators = '|',
        section_separators = '',
      },
    },
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = true
  }
}
