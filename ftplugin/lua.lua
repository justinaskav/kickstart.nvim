local set = vim.keymap.set

set("n", "<leader>y", "<cmd>.lua<CR>", { desc = "Execute the current line" })
set("n", "<leader>Y", "<cmd>source %<CR>", { desc = "Execute the current file" })

-- Quickly change window size
set("n", "<C-,>", "<c-w>5<")
set("n", "<C-.>", "<c-w>5>")
set("n", "<C-k>", "<C-W>+")
set("n", "<C-j>", "<C-W>-")
