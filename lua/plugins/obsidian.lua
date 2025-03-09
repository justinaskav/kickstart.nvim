local vault_path = "/Users/justinas/Obsidian/Thinking"
local vault_path2 = "/Users/justinas/Obsidian/Science"

return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
    "BufReadPre " .. vault_path .. "/**.md",
    "BufNewFile " .. vault_path .. "/**.md",
    "BufReadPre " .. vault_path2 .. "/**.md",
    "BufNewFile " .. vault_path2 .. "/**.md",
  },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
    -- see below for full list of optional dependencies 👇
  },
  opts = {
    workspaces = {
      {
        name = "Thinking",
        path = vault_path,
      },
      {
        name = "Science",
        path = vault_path2,
      },
    },
    -- completion = {
    --   prepend_note_id = false,
    --   prepend_note_path = true,
    -- },
    disable_frontmatter = true
  },
}
