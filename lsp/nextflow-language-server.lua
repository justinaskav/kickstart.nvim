local cmd = function()
  -- Get the path relative to nvim config
  local config_dir = vim.fn.stdpath('config')
  return { "java", "-jar", config_dir .. '/bin/language-server-all.jar' }
end


return {
  cmd = cmd(),
  filetypes = { 'nextflow', 'groovy' },
  root_markers = { 'nextflow.config' },
  settings = {
    nextflow = {
      files = {
        exclude = { '.git', '.nf-test', 'work' },
      },
    },
  },
}
