return {
  cmd = { 'R', '--no-echo', '-e', 'languageserver::run()' },
  filetypes = { 'r', 'rmd', 'quarto' },
  log_level = vim.lsp.protocol.MessageType.Warning,
  settings = {
    lsp = {
      rich_documentation = false,
    }
  }
}
