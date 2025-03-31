return {
  -- Add the Laravel.nvim plugin which gives the ability to run Artisan commands
  -- from Neovim.
  "adalessa/laravel.nvim",
  dependencies = {
    "tpope/vim-dotenv",
    "nvim-telescope/telescope.nvim",
    "MunifTanjim/nui.nvim",
    "kevinhwang91/promise-async",
  },
  ft = { "php", "vue" },
  cmd = { "Sail", "Artisan", "Composer", "Npm", "Yarn", "Laravel" },
  -- event = { "VeryLazy" },
  opts = {
    lsp_server = "intelephense",
    features = { null_ls = { enable = false } },
  },
  config = function(_, opts)
    require("laravel").setup(opts)

    vim.keymap.set("n", "<leader>la",
      ":Laravel artisan<CR>", { desc = "[L]aravel [A]rtisan" })

    vim.keymap.set("n", "<leader>lt",
      ":Laravel tinker<CR>", { desc = "[L]aravel [T]inker" })

    vim.keymap.set("n", "<leader>lR",
      ":Laravel routes<CR>", { desc = "[L]aravel [R]outes" })
  end
}
