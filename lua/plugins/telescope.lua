-- Fuzzy Finder (files, lsp, etc)

return {
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      -- {
      --   'jmbuhr/telescope-zotero.nvim',
      --   enabled = true,
      --   dev = false,
      --   dependencies = {
      --     { 'kkharji/sqlite.lua' },
      --   },
      --   config = function()
      --     vim.keymap.set('n', '<leader>fz', ':Telescope zotero<cr>', { desc = '[z]otero' })
      --   end,
      -- },
    },
    config = function()
      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        defaults = {
          mappings = {
            i = {
              ['<C-u>'] = false,
              ['<C-d>'] = false,
            },
            -- n = {
            --   ["d"] = "delete_buffer"
            -- }
          },
        },
        pickers = {
          diagnostics = {
            -- Only show the list of diagnostics if there are more than 2
            -- This means that if there is only one item, it will open the item
            -- directly.
            threshold = 2,
            wrap_results = true
          },
          buffers = {
            sort_mru = true,
            -- previewer = false,
            mappings = {
              i = {
                ["<c-d>"] = "delete_buffer",
              },
              n = {
                ["<c-d>"] = "delete_buffer",
              }
            }
          },
        },
        -- extensions = {
        --   frecency = {
        --     show_unindexed = false
        --   }
        -- }
      }

      -- Enable telescope fzf native, if installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
      -- require('telescope').load_extension('zotero')

      -- Custom live_grep function to search in git root
      local function live_grep_git_root()
        local git_root = vim.fs.root(0, '.git')
        if git_root then
          require('telescope.builtin').live_grep({
            search_dirs = { git_root },
          })
        end
      end

      -- See `:help telescope.builtin`
      vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
      vim.keymap.set('n', '<leader><leader>', require('telescope.builtin').buffers,
        { desc = '[ ] Find existing buffers' })
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = '[G]it File [S]earch' })
      vim.keymap.set('n', '<leader>gg', live_grep_git_root, { desc = '[G]it Root Search by [G]rep' })
      vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>so', ':TodoTelescope<cr>', { desc = '[S]earch [O]utstanding TODOs' })
      vim.keymap.set('n', '<leader>ss', require('telescope.builtin').resume, { desc = '[S]earch Re[s]ume' })
      vim.keymap.set('n', '<leader>st', require('telescope.builtin').treesitter, { desc = '[S]earch [T]reesitter' })
      vim.keymap.set('n', '<leader>sc', require('telescope.builtin').commands, { desc = '[S]earch [C]ommands' })
      -- Search History
      vim.keymap.set('n', '<leader>sm', require('telescope.builtin').command_history,
        { desc = '[S]earch Co[m]mand History' })
      vim.keymap.set('n', '<leader>si', require('telescope.builtin').search_history,
        { desc = '[S]earch Search History' })
      vim.keymap.set('n', '<leader>sz', require('telescope.builtin').colorscheme, { desc = '[S]earch for a Colorscheme' })
      vim.keymap.set('n', '<leader>sk', require('telescope.builtin').keymaps, { desc = '[S]earch for [K]eymaps' })
      vim.keymap.set('n', '<leader>sp', require('telescope.builtin').filetypes, { desc = '[S]earch for [P]lugins' })
    end
  },
  -- {
  --   "nvim-telescope/telescope-frecency.nvim",
  --   config = function()
  --     require("telescope").load_extension "frecency"
  --
  --     vim.keymap.set("n", "<leader>.", "<Cmd>Telescope frecency workspace=CWD<CR>",
  --       { desc = '[.] Find most opened files' })
  --   end,
  -- },
}
