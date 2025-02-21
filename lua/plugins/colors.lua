return {
  {
    'navarasu/onedark.nvim',
    priority = 1000,
    enabled = false,
    -- config = function()
    --   require('onedark').setup {
    --     style = 'darker',
    --     transparent = true
    --   }
    --   vim.cmd [[colorscheme onedark]]
    --   vim.cmd [[highlight CodeBlock guibg=#272731]]
    -- end,
  },
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "night",
        transparent = true,
      })

      vim.cmd [[colorscheme tokyonight]]
      vim.cmd [[highlight CodeBlock guibg=#272731]]
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    enabled = false,
    -- config = function()
    --   require('catppuccin').setup({
    --     transparent_background = true,
    --   })
    -- end,
  }
}
