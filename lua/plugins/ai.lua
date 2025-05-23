return {
  {
    "zbirenbaum/copilot.lua",
    opts = {
      panel = { enabled = false },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
          accept = "<C-l>",
          accept_word = false,
          accept_line = false,
          prev = false,
          next = "<C-]>",
          dismiss = false,
        },
      },
      filetypes = {
        yaml = true,
        markdown = true,
        help = false,
        gitcommit = true,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        ["."] = false,
      },
    }
  },
  {
    "yetone/avante.nvim",
    -- "Yeastiest/avantegeminitools",
    -- name = "avante.nvim",
    -- lazy = false,
    keys = {
      { "<leader>va", "<cmd>AvanteToggle<CR>", desc = "Toggle [A]vante" }
    },
    cmd = { "AvanteToggle", "AvanteAsk" },
    version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
    opts = {
      -- add any opts here
      -- for example
      provider = "gemini",
      cursor_applying_provider = "gemini",
      gemini = {
        endpoint = "https://generativelanguage.googleapis.com/v1beta/models",
        model = "gemini-2.0-flash",
        timeout = 30000, -- Timeout in milliseconds
        temperature = 1,
        max_tokens = 8192,
      },
      vendors = {
        ["ollama-qwen"] = {
          __inherited_from = "ollama",
          model = "qwen2.5-coder:14b",
          -- max_tokens = 32768
        },
        ["copilot-claude-3.5"] = {
          __inherited_from = "copilot",
          model = "claude-3.5-sonnet",
          max_tokens = 32768
        },
        ["copilot-claude-3.7"] = {
          __inherited_from = "copilot",
          model = "claude-3.7-sonnet",
          max_tokens = 32768
        },
      },
      web_search_engine = {
        provider = "google", -- tavily, serpapi, searchapi, google or kagi
      },
      system_prompt = function()
        local hub = require("mcphub").get_hub_instance()
        local prompt = hub:get_active_servers_prompt()
        return prompt
      end,
    },
    config = function(_, opts)
      require("avante").setup(opts)

      require("which-key").add({
        { "<leader>a",  group = "[A]vante" },
        { "<leader>a_", hidden = true },
      })
    end,
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "make BUILD_FROM_SOURCE=true",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      {
        "ravitemer/mcphub.nvim",
        dependencies = {
          "nvim-lua/plenary.nvim", -- Required for Job and HTTP requests
        },
        -- comment the following line to ensure hub will be ready at the earliest
        cmd = "MCPHub",                          -- lazy load by default
        build = "npm install -g mcp-hub@latest", -- Installs required mcp-hub npm module
        -- uncomment this if you don't want mcp-hub to be available globally or can't use -g
        -- build = "bundled_build.lua",  -- Use this and set use_bundled_binary = true in opts  (see Advanced configuration)
        opts = {
          config = vim.fn.expand("~/.config/mcp/servers.json"),
          extensions = {
            avante = {
              make_slash_commands = true, -- make /slash commands from MCP server prompts
            },
          }
        },
      },
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "nvim-tree/nvim-web-devicons",   -- or echasnovski/mini.icons

      -- {
      --   -- support for image pasting
      --   "HakonHarnes/img-clip.nvim",
      --   event = "VeryLazy",
      --   opts = {
      --     -- recommended settings
      --     default = {
      --       embed_image_as_base64 = false,
      --       prompt_for_file_name = false,
      --       drag_and_drop = {
      --         insert_mode = true,
      --       },
      --       -- required for Windows users
      --       use_absolute_path = true,
      --     },
      --   },
      -- },
    }
  },
}
