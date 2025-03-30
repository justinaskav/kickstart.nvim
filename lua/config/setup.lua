-- disable netrw at the very start of your init.lua
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- remove netrw banner for cleaner looking
-- vim.g.netrw_banner = 0

vim.g.mapleader = vim.keycode("<space>")
vim.g.maplocalleader = vim.keycode("<cr>")

-- Fold
vim.o.foldenable = true   -- enable fold
vim.o.foldlevel = 99      -- start editing with all folds opened
vim.o.foldmethod = "expr" -- use tree-sitter for folding method
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- disable fill chars (the ~ after the buffer)
-- vim.o.fillchars = 'eob: '

-- mode is already in statusline
vim.o.showmode = false

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

vim.o.hlsearch = true
vim.o.incsearch = true

vim.o.cursorline = true -- enable cursor line

-- Make line numbers and relative numbering default
vim.o.number = true
vim.o.relativenumber = true

-- Indent
vim.o.smartindent = true -- auto-indenting when starting a new line
vim.o.shiftround = true  -- round indent to multiple of 'shiftwidth'
vim.o.shiftwidth = 0     -- 0 to follow the 'tabstop' value
vim.o.tabstop = 4        -- tab width

vim.o.expandtab = true
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
vim.o.signcolumn = 'yes'

-- Decrease update time
-- vim.o.confirm = true     -- show dialog for unsaved file(s) before quit
vim.o.updatetime = 200 -- save swap file with 200ms debouncing

vim.o.timeoutlen = 250

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

vim.opt.listchars = { -- NOTE: using `vim.opt` instead of `vim.o` to pass rich object
  tab = "▏ ",
  trail = "·",
  extends = "»",
  precedes = "«",
}

-- Don't scroll down more than 8 lines when scrolling off the screen
vim.o.scrolloff = 8

vim.o.pumheight = 12 -- max height of completion menu

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

-- For Avante, suggested setting
-- vim.opt.laststatus = 3 -- views can only be fully collapsed with the global statusline

-- If nvim 0.11.0 or later
if vim.fn.has("nvim-0.11") == 1 then
  vim.o.winborder = 'rounded'

  -- As per https://github.com/nvim-telescope/telescope.nvim/issues/3436
  vim.api.nvim_create_autocmd("User", {
    pattern = "TelescopeFindPre",
    callback = function()
      vim.opt_local.winborder = "none"
      vim.api.nvim_create_autocmd("WinLeave", {
        once = true,
        callback = function()
          vim.opt_local.winborder = "rounded"
        end,
      })
    end,
  })
end

vim.diagnostic.config({ virtual_text = true })
