return {
  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lsp-signature-help" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      -- { "hrsh7th/cmp-calc" },
      { "saadparwaiz1/cmp_luasnip" },
      -- { "f3fora/cmp-spell" },
      { "ray-x/cmp-treesitter" },
      { "kdheepak/cmp-latex-symbols" },
      { "jmbuhr/cmp-pandoc-references" },
      {
        "L3MON4D3/LuaSnip",
        version = nil,
        branch = "master",
        dependencies = {
          -- Adds a number of user-friendly snippets
          'rafamadriz/friendly-snippets',
        }
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
        }
      },
    },
    config = function()
      -- [[ Configure nvim-cmp ]]
      -- See `:help cmp`
      local cmp = require 'cmp'

      local luasnip = require 'luasnip'
      require('luasnip.loaders.from_vscode').lazy_load()

      -- link quarto and rmarkdown to markdown snippets
      luasnip.filetype_extend("quarto", { "markdown" })
      luasnip.filetype_extend("rmarkdown", { "markdown" })

      luasnip.config.setup {}

      local lspkind = require 'lspkind'

      ---@diagnostic disable-next-line missing-fields
      cmp.setup({
        completion = { completeopt = 'menu,menuone,noinsert', },
        view = { entries = 'native', },
        window = {
          documentation = {
            border = require("misc.style").border,
          },
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
          {
            name = 'nvim_lsp',
            entry_filter = function(entry, ctx)
              return entry:get_kind() ~= cmp.lsp.CompletionItemKind.Text and
                  entry:get_kind() ~= cmp.lsp.CompletionItemKind.Snippet
            end
          },
          { name = "nvim_lsp_signature_help" },
          { name = "otter" }, -- for code chunks in quarto
          { name = "path" },
          { name = "pandoc_references" },
          { name = "luasnip",                keyword_length = 3, max_item_count = 3 },
          { name = "buffer",                 keyword_length = 5, max_item_count = 3 },
          { name = "treesitter",             keyword_length = 5, max_item_count = 3 },
          -- { name = "calc" },
          { name = "latex_symbols" },
        },
      })
    end
  }
}
