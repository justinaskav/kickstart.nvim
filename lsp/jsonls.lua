---@type vim.lsp.Config
return {
        cmd = { 'vscode-json-language-server', '--stdio' },
        filetypes = { 'json', 'jsonc' },
        settings = {
            json = {
                -- schemas = require('schemastore').json.schemas(),
                validate = { enable = true },
            },
        },
        init_options = {
            provideFormatter = true,
        },
        single_file_support = true,
}
