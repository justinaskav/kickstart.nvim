-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>de', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>dq', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Move selected line / block of text in visual mode
vim.keymap.set('v', "J", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set('v', "K", ":m '<-2<CR>gv=gv", { silent = true })

-- Center screen after jumping to a new line
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = 'Scroll down and center' })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = 'Scroll up and center' })

-- Quarto Keymaps
vim.keymap.set("n", "<leader>qp", ":QuartoPreview<CR>", { desc = '[P]review Quarto document' })
vim.keymap.set("n", "<C-CR>", "<Plug>SlimeSendCell", { desc = 'Slime: Send current cell to terminal' })
vim.keymap.set("v", "<S-CR>", "<Plug>SlimeRegionSend", { desc = 'Slime: Send selected region to terminal' })

local wk = require("which-key")

wk.register({
	['c'] = { name = "[C]ode", _ = 'which_key_ignore' },
	['d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
	['g'] = { name = '[G]it', _ = 'which_key_ignore' },
	-- ['<leader>h'] = { name = 'More git', _ = 'which_key_ignore' },
	['l'] = { name = '[L]aravel', _ = 'which_key_ignore' },
	['q'] = { name = '[Q]uarto', _ = 'which_key_ignore' },
	['r'] = { name = '[R]ename', _ = 'which_key_ignore' },
	['s'] = { name = '[S]earch', _ = 'which_key_ignore' },
	['v'] = { name = '[V]im', _ = 'which_key_ignore' },
	-- ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
}, { prefix = '<leader>' })

-- For window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move to left window' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move to bottom window' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move to top window' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move to right window' })

-- Split window

-- vim.keymap.set('n', '<C-H>', ':leftabove vnew<CR>', { desc = 'Split window left' })
-- vim.keymap.set('n', '<C-J>', ':belowright new<CR>', { desc = 'Split window down' })
-- vim.keymap.set('n', '<C-K>', ':aboveleft new<CR>', { desc = 'Split window up' })
-- vim.keymap.set('n', '<C-L>', ':rightbelow vnew<CR>', { desc = 'Split window right' })

-- For buffer navigation
vim.keymap.set('n', '<TAB>', ':bnext<CR>', { desc = 'Move to next buffer' })
vim.keymap.set('n', '<S-TAB>', ':bprevious<CR>', { desc = 'Move to previous buffer' })
