return {
  {
    "quarto-dev/quarto-nvim",
    dev = false,
    ft = { "quarto" },
    dependencies = {
      {
        "jmbuhr/otter.nvim",
        dev = false,
        dependencies = {
          { "neovim/nvim-lspconfig" },
        },
        opts = {
          -- lsp = {
          --   hover = {
          --     border = require("misc.style").border,
          --   },
          -- },
          buffers = {
            set_filetype = true,
          },
          handle_leading_whitespace = true,
        },
      },
    },
    config = function()
      require('quarto').setup({
        lspFeatures = {
          languages = { "r", "python", "julia", "bash", "lua", "html", "dot", "javascript", "typescript", "ojs" },
        },
      })

      vim.keymap.set("n", "<leader>qp", ":QuartoPreview<CR>", { desc = '[P]review Quarto document' })

      require('which-key').add({
        { "<leader>q",  group = "[Q]uarto" },
        { "<leader>q_", hidden = true },
      })
    end,
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
    enabled = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter"
    },
    ft = { "markdown", "quarto" },
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
    ft = { "python", "r", "quarto" },
    keys = {
      { "<leader>vs", ":SlimeConfig<CR>", desc = "Config [S]lime" },
    },
    init = function()
      -- these two should be set before the plugin loads
      vim.g.slime_target = "neovim"
      vim.g.slime_python_ipython = 1
      vim.g.slime_no_mappings = true
    end,
    config = function()
      vim.g.slime_input_pid = false
      vim.g.slime_suggest_default = true
      vim.g.slime_menu_config = false
      vim.g.slime_neovim_ignore_unlisted = false

      -- options not set here are g:slime_neovim_menu_order, g:slime_neovim_menu_delimiter, and g:slime_get_jobid
      -- see the documentation above to learn about those options

      vim.b['quarto_is_python_chunk'] = false
      Quarto_is_in_python_chunk = function()
        require('otter.tools.functions').is_otter_language_context 'python'
      end

      vim.cmd [[
      let g:slime_dispatch_ipython_pause = 100
      function SlimeOverride_EscapeText_quarto(text)
      call v:lua.Quarto_is_in_python_chunk()
      if exists('g:slime_python_ipython') && len(split(a:text,"\n")) > 1 && b:quarto_is_python_chunk && !(exists('b:quarto_is_r_mode') && b:quarto_is_r_mode)
      return ["%cpaste -q\n", g:slime_dispatch_ipython_pause, a:text, "--", "\n"]
      else
      if exists('b:quarto_is_r_mode') && b:quarto_is_r_mode && b:quarto_is_python_chunk
      return [a:text, "\n"]
      else
      return [a:text]
      end
      end
      endfunction
      ]]

      -- called MotionSend but works with textobjects as well
      -- vim.keymap.set("n", "gz", "<Plug>SlimeMotionSend", { remap = true, silent = false })
      -- vim.keymap.set("n", "gzz", "<Plug>SlimeLineSend", { remap = true, silent = false })
      -- vim.keymap.set("n", "gzc", "<Plug>SlimeConfig", { remap = true, silent = false })
      --
      --- Send code to terminal with vim-slime
      --- If an R terminal has been opend, this is in r_mode
      --- and will handle python code via reticulate when sent
      --- from a python chunk.
      --- TODO: incorpoarate this into quarto-nvim plugin
      --- such that QuartoRun functions get the same capabilities
      --- TODO: figure out bracketed paste for reticulate python repl.
      local function send_cell()
        if vim.b['quarto_is_r_mode'] == nil then
          vim.fn['slime#send_cell']()
          return
        end
        if vim.b['quarto_is_r_mode'] == true then
          vim.g.slime_python_ipython = 0
          local is_python = require('otter.tools.functions').is_otter_language_context 'python'
          if is_python and not vim.b['reticulate_running'] then
            vim.fn['slime#send']('reticulate::repl_python()' .. '\r')
            vim.b['reticulate_running'] = true
          end
          if not is_python and vim.b['reticulate_running'] then
            vim.fn['slime#send']('exit' .. '\r')
            vim.b['reticulate_running'] = false
          end
          vim.fn['slime#send_cell']()
        end
      end

      vim.b.slime_cell_delimiter = "# %%"

      vim.keymap.set('n', "<C-CR>", send_cell, { desc = "Send cell to Slime terminal" })
      vim.keymap.set('n', "<S-CR>", "<Plug>SlimeRegionSend", { desc = "Send region to Slime terminal" })
      -- vim.keymap.set("x", "<S-CR>", "<Plug>SlimeRegionSend", { remap = true, silent = false })
      vim.keymap.set("v", "<S-CR>", "<Plug>SlimeRegionSend", { desc = 'Slime: Send selected region to terminal' })

      vim.keymap.set("n", "<leader>tm", "<Plug>SlimeConfig", { desc = "[M]ark terminal to use with Slime" })
    end,
  },

  -- paste an image to markdown from the clipboard
  -- :PasteImg,
  -- { "dfendr/clipboard-image.nvim", cmd = "PasteImg" },
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
