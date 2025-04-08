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
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if path ~= vim.fn.stdpath('config') and (vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc')) then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT'
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        -- library = {
        --   vim.env.VIMRUNTIME
        --   -- Depending on the usage, you might want to add additional paths here.
        --   -- "${3rd}/luv/library"
        --   -- "${3rd}/busted/library",
        -- }
        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
        library = vim.api.nvim_get_runtime_file("", true)
      }
    })
  end,
  settings = {
    Lua = {
      -- completion = {
      --   callSnippet = 'Replace',
      -- },
      -- runtime = {
      --   version = 'LuaJIT',
      --   -- plugin = lua_plugin_paths, -- handled by lazydev
      -- },
      -- diagnostics = {
      --   globals = { "vim", "require", "quarto", "pandoc", "io", "string", "print", "table" },
      --   disable = { 'trailing-space' },
      -- },
      -- workspace = {
      --   -- library = lua_library_files, -- handled by lazydev
      --   checkThirdParty = false,
      -- },
      -- doc = {
      --   privateName = { '^_' },
      -- },
      telemetry = {
        enable = false,
      },
    },
  },
  single_file_support = true,
  log_level = vim.lsp.protocol.MessageType.Warning
}
