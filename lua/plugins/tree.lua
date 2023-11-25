return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup({
      update_focused_file = {
        enable = true
      }
    })

    vim.api.nvim_set_keymap("n", "<leader>vt", ":NvimTreeToggle<CR>",
      { noremap = true, silent = true, desc = "Toggle File [T]ree" })
  end,
}
