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
      { "hrsh7th/cmp-calc" },
      { "hrsh7th/cmp-emoji" },
      { "saadparwaiz1/cmp_luasnip" },
      { "f3fora/cmp-spell" },
      { "ray-x/cmp-treesitter" },
      { "kdheepak/cmp-latex-symbols" },
      { "jmbuhr/cmp-pandoc-references" },
      {
        "L3MON4D3/LuaSnip",
        version = nil,
        branch = "master",
      },

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
      'onsails/lspkind-nvim',
      {
        "zbirenbaum/copilot.lua",
        config = function()
          require("copilot").setup({
            suggestion = {
              enabled = true,
              auto_trigger = true,
              debounce = 75,
              keymap = {
                accept = "<c-a>",
                accept_word = false,
                accept_line = false,
                next = "<M-]>",
                prev = "<M-[>",
                dismiss = "<C-]>",
              },
            },
            panel = { enabled = false },
          })
        end,
      },
    },
    config = function()
      -- [[ Configure nvim-cmp ]]
      -- See `:help cmp`
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      local lspkind = require 'lspkind'

      lspkind.init()

      require('luasnip.loaders.from_vscode').lazy_load()
      luasnip.config.setup {}

      ---@diagnostic disable-next-line missing-fields
      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          -- Disable because of indent issues
          -- ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          -- ['<C-f>'] = cmp.mapping.scroll_docs(4),
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
        autocomplete = false,
        formatting = {
          format = lspkind.cmp_format({
            with_text = true,
            menu = {
              otter = "[🦦]",
              luasnip = "[snip]",
              nvim_lsp = "[LSP]",
              buffer = "[buf]",
              path = "[path]",
              spell = "[spell]",
              pandoc_references = "[ref]",
              tags = "[tag]",
              treesitter = "[TS]",
              calc = "[calc]",
              latex_symbols = "[tex]",
              emoji = "[emoji]",
            },
          }),
        },
        sources = {
          { name = "otter" }, -- for code chunks in quarto
          { name = "path" },
          { name = "nvim_lsp" },
          { name = "nvim_lsp_signature_help" },
          { name = "luasnip",                keyword_length = 3, max_item_count = 3 },
          { name = "pandoc_references" },
          { name = "buffer",                 keyword_length = 5, max_item_count = 3 },
          { name = "spell" },
          { name = "treesitter",             keyword_length = 5, max_item_count = 3 },
          { name = "calc" },
          { name = "latex_symbols" },
          { name = "emoji" },
        },
        view = {
          entries = "native",
        },
        window = {
          documentation = {
            border = require("misc.style").border,
          },
        },
      }
    end
  }
}
