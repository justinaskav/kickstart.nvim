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

      -- Telescope live_grep in git root
      -- Function to find the git root directory based on the current buffer's path
      local function find_git_root()
        -- Use the current buffer's path as the starting point for the git search
        local current_file = vim.api.nvim_buf_get_name(0)
        local current_dir
        local cwd = vim.fn.getcwd()
        -- If the buffer is not associated with a file, return nil
        if current_file == "" then
          current_dir = cwd
        else
          -- Extract the directory from the current file's path
          current_dir = vim.fn.fnamemodify(current_file, ":h")
        end

        -- Find the Git root directory from the current file's path
        local git_root = vim.fn.systemlist("git -C " .. vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")
            [1]
        if vim.v.shell_error ~= 0 then
          print("Not a git repository. Searching on current working directory")
          return cwd
        end
        return git_root
      end

      -- Custom live_grep function to search in git root
      local function live_grep_git_root()
        local git_root = find_git_root()
        if git_root then
          require('telescope.builtin').live_grep({
            search_dirs = { git_root },
          })
        end
      end

      vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})

      -- See `:help telescope.builtin`
      vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
      vim.keymap.set('n', '<leader><leader>', require('telescope.builtin').buffers,
        { desc = '[ ] Find existing buffers' })
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 50,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = '[G]it File [S]earch' })
      vim.keymap.set('n', '<leader>gg', ':LiveGrepGitRoot<cr>', { desc = '[G]it Root Search by [G]rep' })
      vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>so', ':TodoTelescope<cr>', { desc = '[S]earch [O]utstanding TODOs' })
      vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>si', require('telescope.builtin').lsp_implementations,
        { desc = '[S]earch [I]mplementations' })
      vim.keymap.set('n', '<leader>st', require('telescope.builtin').treesitter, { desc = '[S]earch [T]reesitter' })
      vim.keymap.set('n', '<leader>sc', require('telescope.builtin').commands, { desc = '[S]earch [C]ommands' })
      -- Search History
      vim.keymap.set('n', '<leader>sm', require('telescope.builtin').command_history,
        { desc = '[S]earch Co[m]mand History' })
      vim.keymap.set('n', '<leader>ss', require('telescope.builtin').search_history,
        { desc = '[S]earch [S]earch History' })
      vim.keymap.set('n', '<leader>sz', require('telescope.builtin').colorscheme, { desc = '[S]earch for a Colorscheme' })
      vim.keymap.set('n', '<leader>sk', require('telescope.builtin').keymaps, { desc = '[S]earch for [K]eymaps' })
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
