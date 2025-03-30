-- From https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/marksman.lua
---@type vim.lsp.Config
return {
    cmd = { 'marksman', 'server' },
    filetypes = { 'markdown', 'markdown.mdx', 'quarto' },
    root_markers = { ".git", ".marksman.toml" },
    single_file_support = true,
}
