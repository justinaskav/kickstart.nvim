return {
  "simrat39/symbols-outline.nvim",
  cmd = "SymbolsOutline",
  keys = {
    { "<leader>lo", ":SymbolsOutline<cr>", desc = "Symbols Outline" },
  },
  config = function()
    require("symbols-outline").setup()
  end,
}
