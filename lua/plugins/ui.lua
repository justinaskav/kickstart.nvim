return {
  -- "nvim-tree/nvim-web-devicons",
  -- {
  --   "nvim-tree/nvim-tree.lua",
  --   version = "*",
  --   lazy = false,
  --   opts = {
  --     update_focused_file = {
  --       enable = true
  --     }
  --   },
  --   keys = {
  --     { "<leader>vt", ":NvimTreeToggle<CR>", noremap = true, silent = true, desc = "Toggle File [T]ree" },
  --   },
  -- },
  {
    "simrat39/symbols-outline.nvim",
    keys = {
      { "<leader>vo", ":SymbolsOutline<CR>", desc = "Toggle Symbols [O]utline" },
    },
    opts = {
      position = "right",
    }
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      options = {
        -- theme = 'tokyonight',
        disabled_filetypes = {
          statusline = { "Avante", "AvanteSelectedFiles" },
        },
        component_separators = '|',
        section_separators = '',
      },
      sections = {
        lualine_c = {
          {
            "filename",
            path = 1,
          },
        },
        lualine_x = {
          function()
            local ok, pomo = pcall(require, "pomo")
            if not ok then
              return ""
            end

            local timer = pomo.get_first_to_finish()
            if timer == nil then
              return ""
            end

            return "󰄉 " .. tostring(timer)
          end,
          "encoding",
          "fileformat",
          "filetype",
        },
      },
    },
  },
}
