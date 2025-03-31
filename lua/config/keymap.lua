-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
-- vim.keymap.set('n', 'go', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })

-- Move selected line / block of text in visual mode
vim.keymap.set('v', "J", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set('v', "K", ":m '<-2<CR>gv=gv", { silent = true })

-- Center screen after jumping to a new line
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = 'Scroll down and center' })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = 'Scroll up and center' })

-- For buffer navigation
-- vim.keymap.set('n', '<TAB>', ':bnext<CR>', { desc = 'Move to next buffer' })
-- vim.keymap.set('n', '<S-TAB>', ':bprevious<CR>', { desc = 'Move to previous buffer' })
vim.keymap.set("n", "<leader>tt", ":split term://$SHELL<cr>", { desc = "New [T]erminal" })
vim.keymap.set("n", "<leader>tr", ":split term://R<cr>", { desc = "New [R] terminal" })
vim.keymap.set("n", "<leader>tp", ":split term://python<cr>", { desc = "New [P]ython terminal" })
vim.keymap.set("n", "<leader>ti", ":split term://ipython<cr>", { desc = "New [I]Python terminal" })
vim.keymap.set("n", "<leader>tv", ":vsplit term://ipython<cr> <C-w>L :vert res 80<cr>",
	{ desc = "New [V]ertical IPython terminal" })
vim.keymap.set("n", "<leader>tj", ":split term://julia<cr>", { desc = "New [J]ulia terminal" })

require("which-key").add({
	{ "<leader>g",  group = "[G]it" },
	{ "<leader>g_", hidden = true },
	{ "<leader>r",  group = "[R]ename" },
	{ "<leader>r_", hidden = true },
	{ "<leader>s",  group = "[S]earch" },
	{ "<leader>s_", hidden = true },
	{ "<leader>v",  group = "[V]im Plugins" },
	{ "<leader>v_", hidden = true },
	{ "<leader>x",  group = "[X] Trouble" },
	{ "<leader>x_", hidden = true },
	{ "<leader>l",  group = "[L]aravel" },
	{ "<leader>l_", hidden = true },
	{ "<leader>t",  group = "[T]erminal" },
	{ "<leader>t_", hidden = true },
})

-- For window navigation
-- vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move to left window' })
-- vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move to bottom window' })
-- vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move to top window' })
-- vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move to right window' })

-- Split window

-- vim.keymap.set('n', '<C-H>', ':leftabove vnew<CR>', { desc = 'Split window left' })
-- vim.keymap.set('n', '<C-J>', ':belowright new<CR>', { desc = 'Split window down' })
-- vim.keymap.set('n', '<C-K>', ':aboveleft new<CR>', { desc = 'Split window up' })
-- vim.keymap.set('n', '<C-L>', ':rightbelow vnew<CR>', { desc = 'Split window right' })
