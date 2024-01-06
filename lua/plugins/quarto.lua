return {
  {
    "quarto-dev/quarto-nvim",
    dev = false,
    dependencies = {
      {
        "jmbuhr/otter.nvim",
        dev = false,
        dependencies = {
          { "neovim/nvim-lspconfig" },
        },
        opts = {
          lsp = {
            hover = {
              border = require("misc.style").border,
            },
          },
        },
      },
    },
    opts = {
      lspFeatures = {
        languages = { "r", "python", "julia", "bash", "lua", "html" },
      },
    },
    ft = { "quarto" },
  },
  -- Some time in the future, when QIIME2 supports Python 3.10 with match statements
  -- But right now I'll just use slime
  --[[ {
        dir = "~/Repositories/molten-nvim",
        -- version = "^1.0.0",     -- use version <2.0.0 to avoid breaking changes
        dependencies = { "3rd/image.nvim" },
        keys = {
          { "<leader>me", ":MoltenEvaluateOperator<CR>",      silent = true, noremap = true, desc = "Run Operator Selection Evaluation" },
          { "<leader>ml", ":MoltenEvaluateLine<CR>",          silent = true, noremap = true, desc = "Evaluate Line" },
          { "<leader>mr", ":MoltenReevaluateCell<CR>",        silent = true, noremap = true, desc = "Re-Evaluate Cell" },
          { "<leader>mv", ":<C-u>MoltenEvaluateVisual<CR>gv", mode = "v",    silent = true,  noremap = true,                            desc = "Evaluate [V]isual Selection" }
        },
        init = function()
          -- these are examples, not defaults. Please see the readme
          vim.g.molten_image_provider = "image.nvim"
          vim.g.molten_output_win_max_height = 20
          vim.g.molten_auto_open_output = false
        end,
    }]]
  {
    "lukas-reineke/headlines.nvim",
    dependencies = { 
      "nvim-treesitter/nvim-treesitter"
    },
    config = function()
      require("headlines").setup({
        markdown = {
          headline_highlights = false
        },
        quarto = {
          query = vim.treesitter.query.parse(
            "markdown",
            [[
                (fenced_code_block) @codeblock
            ]]
          ),
          codeblock_highlight = "CodeBlock",
          treesitter_language = "markdown",
        },
      })
    end
  },

  -- send code from python/r/qmd documets to a terminal or REPL
  -- like ipython, R, bash
  {
    "jpalardy/vim-slime",
    keys = {
      { "<C-CR>",     "<Plug>SlimeSendCell",       desc = "Slime: Send current cell to terminal" },
      { "<S-CR>",     "<Plug>SlimeRegionSend",     desc = "Slime: Send selected region to terminal" },
      { "<leader>cc", ":SlimeConfig<cr>",          desc = "[C]onfig Slime" },
      { "<leader>ct", ":split term://$SHELL<cr>",  desc = "New [T]erminal" },
      { "<leader>cr", ":split term://R<cr",        desc = "New [R] Terminal" },
      { "<leader>cp", ":split term://python<cr>",  desc = "New [P]ython Terminal" },
      { "<leader>ci", ":split term://ipython<cr>", desc = "New [I]Python Terminal" },
      { "<leader>cj", ":split term://julia<cr>",   desc = "New [J]ulia Terminal" },
    },
    config = function()
      vim.b["quarto_is_" .. "python" .. "_chunk"] = false
      Quarto_is_in_python_chunk = function()
        require("otter.tools.functions").is_otter_language_context("python")
      end

      vim.cmd([[
      let g:slime_dispatch_ipython_pause = 100
      function SlimeOverride_EscapeText_quarto(text)
      call v:lua.Quarto_is_in_python_chunk()
      if exists('g:slime_python_ipython') && len(split(a:text,"\n")) > 1 && b:quarto_is_python_chunk
      return ["%cpaste -q\n", g:slime_dispatch_ipython_pause, a:text, "--", "\n"]
      else
      return a:text
      end
      endfunction
      ]])

      local function mark_terminal()
        vim.g.slime_last_channel = vim.b.terminal_job_id
        vim.print(vim.g.slime_last_channel)
      end

      local function set_terminal()
        vim.b.slime_config = { jobid = vim.g.slime_last_channel }
      end

      vim.b.slime_cell_delimiter = "# %%"

      -- slime, neovvim terminal
      vim.g.slime_target = "neovim"
      vim.g.slime_python_ipython = 1

      -- -- slime, tmux
      -- vim.g.slime_target = 'tmux'
      -- vim.g.slime_bracketed_paste = 1
      -- vim.g.slime_default_config = { socket_name = "default", target_pane = ".2" }

      local function toggle_slime_tmux_nvim()
        if vim.g.slime_target == "tmux" then
          pcall(function()
            vim.b.slime_config = nil
            vim.g.slime_default_config = nil
          end)
          -- slime, neovvim terminal
          vim.g.slime_target = "neovim"
          vim.g.slime_bracketed_paste = 0
          vim.g.slime_python_ipython = 1
        elseif vim.g.slime_target == "neovim" then
          pcall(function()
            vim.b.slime_config = nil
            vim.g.slime_default_config = nil
          end)
          -- -- slime, tmux
          vim.g.slime_target = "tmux"
          vim.g.slime_bracketed_paste = 1
          vim.g.slime_default_config = { socket_name = "default", target_pane = ".2" }
        end
      end

      vim.g.slime_no_mappings = 1

      require("which-key").register({
        ["<leader>cm"] = { mark_terminal, "[M]ark terminal" },
        ["<leader>cs"] = { set_terminal, "[S]et terminal" },
        -- ["<leader>ct"] = { toggle_slime_tmux_nvim, "[T]oggle tmux/nvim terminal" },
      })
    end,
  },

  -- paste an image to markdown from the clipboard
  -- :PasteImg,
  { "dfendr/clipboard-image.nvim", cmd = "PasteImg" },
  {
    -- see the image.nvim readme for more information about configuring this plugin
    --[[ "3rd/image.nvim",
    opts = {
      backend = "kitty", -- whatever backend you would like to use
      max_width = 100,
      max_height = 12,
      max_height_window_percentage = math.huge,
      max_width_window_percentage = math.huge,
      window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
    }, ]]
    --[[ dependencies = { {
      'edluffy/hologram.nvim',
      config = function()
        require("hologram").setup()
      end,

      rocks = { "magick" },
    } } ]]
  }

  -- preview equations
  -- {
  --  "jbyuki/nabla.nvim",
  --  keys = {
  --    { "<leader>ee", ':lua require"nabla".toggle_virt()<cr>', "Toggle equations" },
  --    { "<leader>eh", ':lua require"nabla".popup()<cr>',       "Hover equation" },
  --  },
  --},
}
