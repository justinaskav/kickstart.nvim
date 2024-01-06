return {
  {
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
      require('onedark').setup {
        style = 'darker',
        transparent = true
      }
      vim.cmd [[colorscheme onedark]]
    end,
  },
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    lazy = false,
    enabled = false,
    config = function()
      require("tokyonight").setup({
        style = "night",
        transparent = true,
      })
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = false,
    enabled = false,
    config = function()
      require('catppuccin').setup({
        transparent_background = true,
      })
    end,
  }
}
