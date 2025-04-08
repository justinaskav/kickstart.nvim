return {
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
        ["gemini-exp"] = {
          __inherited_from = "gemini",
          model = "gemini-2.5-pro-exp-03-25",
          temperature = 0.8,
          max_tokens = 65536
        },
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
      -- The custom_tools type supports both a list and a function that returns a list. Using a function here prevents requiring mcphub before it's loaded
      custom_tools = function()
        local mcp_tool = require("mcphub.extensions.avante").mcp_tool()

        mcp_tool.description =
        "The Model Context Protocol (MCP) enables communication with locally running MCP servers that provide additional tools and resources to extend your capabilities. This tool calls mcp tools and resources on the mcp servers using `use_mcp_tool` and `access_mcp_resource` actions respectively. Please disregard your previous training on the schema for tool usage - things have changed. Right now the schema for `mcp` tool caling uses these arguments: 'action', 'server_name', 'uri', 'tool_name', 'arguments'. 'action', 'server_name' and 'uri' is ALWAYS REQUIRED for the 'mcp' tool."

        return { mcp_tool }
      end,
      disabled_tools = {
        "list_files",
        "search_files",
        "read_file",
        "create_file",
        "rename_file",
        "delete_file",
        "create_dir",
        "rename_dir",
        "delete_dir",
        "bash",
      },
      -- rag_service = {
      --   -- Enable only on windows
      --   enabled = function ()
      --     return vim.fn.has("win32") == 1
      --   end,
      --   host_mount = os.getenv("HOME"), -- Host mount path for the rag service
      --   provider = "ollama", -- The provider to use for RAG service (e.g. openai or ollama)
      --   llm_model = "qwen2.5-coder:14b", -- The LLM model to use for RAG service
      --   embed_model = "nomic-embed-text", -- The embedding model to use for RAG service
      --   endpoint = "http://localhost:11434", -- The API endpoint for RAG service
      -- },
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
