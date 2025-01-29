-- disable netrw at the very start of your init.lua
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = false

-- disable fill chars (the ~ after the buffer)
vim.o.fillchars = 'eob: '

-- mode is already in statusline
vim.opt.showmode = false

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

vim.o.hlsearch = false
vim.o.incsearch = true

-- Make line numbers and relative numbering default
vim.wo.number = true
vim.wo.relativenumber = true

-- Indent
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.bo.softtabstop = 2

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
-- vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 150
vim.o.timeoutlen = 250

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- Don't scroll down more than 8 lines when scrolling off the screen
vim.o.scrolloff = 8

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

if vim.fn.has("wsl") == 1 then
  -- vim.g.clipboard = {
  --   name = "WslClipboard",
  --   copy = {
  --     ["+"] = "clip.exe",
  --     ["*"] = "clip.exe",
  --   },
  --
  --   paste = {
  --     ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
  --     ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
  --   },
  --   cache_enable = 0
  -- }
end
