return {
  "yetone/avante.nvim",
  keys = {
    { "<leader>va", function() require("avante") end, desc = "Enable Avante" }
  },
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
      temperature = 0,
      max_tokens = 8192,
    },
    vendors = {
      ["gemini-exp"] = {
        __inherited_from = "gemini",
        model = "gemini-2.5-pro-exp-03-25",
        max_tokens = 65536
      },
      ["ollama-qwen"] = {
        __inherited_from = "ollama",
        model = "qwen2.5-coder:14b",
        -- max_tokens = 32768
      }
    },
    web_search_engine = {
      provider = "google", -- tavily, serpapi, searchapi, google or kagi
    }
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
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    "hrsh7th/nvim-cmp",              -- autocompletion for avante commands and mentions
    "nvim-tree/nvim-web-devicons",   -- or echasnovski/mini.icons
    "zbirenbaum/copilot.lua",        -- for providers='copilot'
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
    -- {
    --   -- Make sure to set this up properly if you have lazy=true
    --   'MeanderingProgrammer/render-markdown.nvim',
    --   opts = {
    --     file_types = { "markdown", "Avante" },
    --   },
    --   ft = { "markdown", "Avante" },
    -- },
  },
}
