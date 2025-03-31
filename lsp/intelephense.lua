return {
    cmd = { 'intelephense', '--stdio' },
    -- Instead of HOME, put intelephense folder in XDG_DATA_HOME
    --   init_options = {
    --     globalStoragePath = os.getenv('HOME') .. '/.local/share/intelephense'
    --   }
    filetypes = { 'php' },
    root_markers = { 'composer.json', 'composer.lock' },
}
