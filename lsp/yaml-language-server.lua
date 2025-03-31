return {
  cmd = { 'yaml-language-server', '--stdio' },
  filetypes = { 'yaml', 'yaml.docker-compose', 'yaml.gitlab' },
  single_file_support = true,
  settings = {
    -- https://github.com/redhat-developer/vscode-redhat-telemetry#how-to-disable-telemetry-reporting
    redhat = { telemetry = { enabled = false } },
  },
  yaml = {
    schemas = {
      -- add custom schemas here
      ['http://json.schemastore.org/github-workflow'] = '.github/workflows/*.{yml,yaml}',
      ['http://json.schemastore.org/github-action'] = '.github/action.{yml,yaml}',
    },
    schemaStore = {
      enable = true,
      url = ""
    }
  }
}
