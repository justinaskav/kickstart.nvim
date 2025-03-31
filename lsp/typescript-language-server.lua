local mason_path = vim.fn.stdpath('data') .. '/mason/bin/'
local mason_registry = require('mason-registry')
local vue_language_server_path = mason_registry.get_package('vue-language-server'):get_install_path() .. '/node_modules/@vue/language-server'

return {
  init_options = {
    hostInfo = 'neovim',
    plugins = {
      {
        name = '@vue/typescript-plugin',
        location = vue_language_server_path,
        languages = { 'vue' },
      },
    },
  },
  cmd = { mason_path .. 'typescript-language-server', '--stdio' },
  filetypes = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx',
    'vue'
  },
  -- https://github.com/LazyVim/LazyVim/discussions/1124
  preferences = {
    importModuleSpecifierPreference = 'relative',
  },
  root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json' },
  single_file_support = true,
}
