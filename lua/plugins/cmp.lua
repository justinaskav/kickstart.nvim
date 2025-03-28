return {
  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lsp-signature-help" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-emoji" },
      -- { "hrsh7th/cmp-calc" },
      { "saadparwaiz1/cmp_luasnip" },
      -- { "f3fora/cmp-spell" },
      -- { "ray-x/cmp-treesitter" },
      { "kdheepak/cmp-latex-symbols" },
      { "jmbuhr/cmp-pandoc-references" },
      {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp",
        dependencies = {
          -- Optional dependencies
          -- "saadparwaiz1/cmp_luasnip",
          "rafamadriz/friendly-snippets",
        },
      },
      -- Pictograms
      'onsails/lspkind-nvim',
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
    },
    config = function()
      -- [[ Configure nvim-cmp ]]
      -- See `:help cmp`
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'

      require('luasnip.loaders.from_vscode').lazy_load()

      require('luasnip.loaders.from_vscode').lazy_load { paths = { vim.fn.stdpath 'config' .. '/snips' } }

      -- link quarto and rmarkdown to markdown snippets
      luasnip.filetype_extend("quarto", { "markdown" })
      luasnip.filetype_extend("rmarkdown", { "markdown" })

      luasnip.config.setup {}

      local lspkind = require 'lspkind'

      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      ---@diagnostic disable-next-line missing-fields
      cmp.setup({
        completion = { completeopt = 'menu,menuone,noinsert', },
        view = { entries = 'native', },
        window = {
          -- documentation = {
          --   border = require("misc.style").border,
          -- },
        },
        formatting = { format = lspkind.cmp_format({}) },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },

        mapping = cmp.mapping.preset.insert {
          -- ['<C-g>'] = cmp.mapping(function(fallback)
          --   vim.api.nvim_feedkeys(vim.fn['copilot#Accept'](vim.api.nvim_replace_termcodes('<Tab>', true, true, true)),
          --     'n', true)
          -- end),
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.close(),
          ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          },
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        },
        sources = {
          { name = "otter" }, -- for code chunks in quarto
          { name = "path" },
          {
            name = 'nvim_lsp',
            -- entry_filter = function(entry, ctx)
            --   return entry:get_kind() ~= cmp.lsp.CompletionItemKind.Text and
            --       entry:get_kind() ~= cmp.lsp.CompletionItemKind.Snippet
            -- end
          },
          { name = "nvim_lsp_signature_help" },
          { name = 'luasnip',                keyword_length = 3, max_item_count = 3 },
          { name = 'pandoc_references' },
          { name = 'buffer',                 keyword_length = 5, max_item_count = 3 },
          { name = "emoji" },
          -- { name = "calc" },
          { name = "latex_symbols" },
        },
      })
    end
  }
}
