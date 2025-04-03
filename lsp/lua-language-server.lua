local root_files = {
  '.luarc.json',
  '.luarc.jsonc',
  '.luacheckrc',
  '.stylua.toml',
  'stylua.toml',
  'selene.toml',
  'selene.yml',
}

return {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = root_files,
  settings = {
    Lua = {
      completion = {
        callSnippet = 'Replace',
      },
      runtime = {
        version = 'LuaJIT',
        -- plugin = lua_plugin_paths, -- handled by lazydev
      },
      diagnostics = {
        globals = { "vim", "require", "quarto", "pandoc", "io", "string", "print", "table" },
        disable = { 'trailing-space' },
      },
      workspace = {
        -- library = lua_library_files, -- handled by lazydev
        checkThirdParty = false,
      },
      doc = {
        privateName = { '^_' },
      },
      telemetry = {
        enable = false,
      },
    },
  },
  single_file_support = true,
  log_level = vim.lsp.protocol.MessageType.Warning
}
