-- local mason_path = vim.fn.stdpath('data') .. '/mason/bin/'

local root_files = {
  '.luarc.json',
  '.luarc.jsonc',
  '.luacheckrc',
  '.stylua.toml',
  'stylua.toml',
  'selene.toml',
  'selene.yml',
  '.git',
}

return {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = root_files,
    single_file_support = true,
    log_level = vim.lsp.protocol.MessageType.Warning,
    settings = { 
      Lua = {
        completion = {
          callSnippet = "Replace",
        },
        diagnostics = {
          globals = { "vim", "quarto", "pandoc", "io", "string", "print", "require", "table" },
          disable = { "trailing-space" },
        },
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
      },
    }
}
