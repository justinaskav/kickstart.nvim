require('config.setup')
require('config.lazy')
require('config.keymap')
require('config.lsp')
require('config.autoformat')
require('config.yankHighlight')

-- Add nextflow filetype
vim.filetype.add({
  pattern = {
    ['.*/.*/.*%.nf'] = 'groovy',
    ['.*/.*/.*%.nextflow'] = 'groovy',
    ['.*/.*/.*%.nf.config'] = 'groovy',
    ['.*/.*/.*%.nextflow.config'] = 'groovy',
    ['nextflow.config'] = 'groovy'
  },
})

vim.api.nvim_create_autocmd({ "BufReadCmd" }, {
  pattern = { "*.qzv", "*.qza" },
  callback = function()
    -- Get the current buffer name (file path)
    local file = vim.fn.expand("%")
    -- Create a temporary directory
    local temp_dir = vim.fn.tempname()
    vim.fn.mkdir(temp_dir)

    -- Extract the .qzv file to the temporary directory
    local cmd = string.format("cd %s && unzip '%s'", vim.fn.shellescape(temp_dir), vim.fn.shellescape(file))
    vim.fn.system(cmd)

    -- Close the current buffer (which would show binary content)
    vim.cmd("bdelete")

    -- Open the temp directory in a new buffer
    vim.cmd("edit " .. vim.fn.fnameescape(temp_dir))
  end
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
