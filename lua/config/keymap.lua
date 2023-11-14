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
-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Move selected line / block of text in visual mode
vim.keymap.set('v', "J", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set('v', "K", ":m '<-2<CR>gv=gv", { silent = true })

-- Center screen after jumping to a new line
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = 'Scroll down and center' })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = 'Scroll up and center' })

-- Quarto Keymaps
vim.keymap.set("n", "<leader>qp", ":QuartoPreview<CR>", { desc = 'Preview Quarto document' })
vim.keymap.set("n", "<C-CR>", "<Plug>SlimeSendCell", { desc = 'Send current cell to terminal' })
vim.keymap.set("v", "<S-CR>", "<Plug>SlimeRegionSend", { desc = 'Send selected region to terminal' })

local wk = require("which-key")

-- document existing key chains
wk.register {
  -- ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
  ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
  ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
  -- ['<leader>h'] = { name = 'More git', _ = 'which_key_ignore' },
  ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
  ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
  ['<leader>v'] = { name = '[V]im', _ = 'which_key_ignore' },
  -- ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
}

wk.register({
  ['<leader>c'] = {
    name = "[C]ode",
    c = { ":SlimeConfig<cr>", "[C]onfig Slime" },
    t = { ":split term://$SHELL<cr>", "New [T]erminal" },
    r = { ":split term://R<cr>", "New [R] Terminal" },
    p = { ":split term://python<cr>", "New [P]ython Terminal" },
    i = { ":split term://ipython<cr>", "New [I]Python Terminal" },
    j = { ":split term://julia<cr>", "New [J]ulia Terminal" },
  },
})
