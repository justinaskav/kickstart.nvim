return {
  -- Autocompletion
  {
    'saghen/blink.cmp',
    event = { "UIEnter" },
    -- optional: provides snippets for the snippet source
    dependencies = {
      -- 'rafamadriz/friendly-snippets',
      {
        "jmbuhr/cmp-pandoc-references",
        'Kaiser-Yang/blink-cmp-avante',
        branch = "adding-typst-support"
      },
      "moyiz/blink-emoji.nvim",
      "mikavilpas/blink-ripgrep.nvim"
    },
    -- use a release tag to download pre-built binaries
    version = '*',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
      -- 'super-tab' for mappings similar to vscode (tab to accept)
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- All preset have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = { preset = 'enter' },

      signature = {
        enabled = true,
        window = {
          border = 'single',
          show_documentation = false
        }
      },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono'
      },

      completion = {
        menu = { border = 'none' },
        documentation = {
          -- (Default) Only show the documentation popup when manually triggered
          auto_show = true
        }
      },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        providers = {
          references = { name = "pandoc_references", module = "cmp-pandoc-references.blink", },
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink", -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,
          },
          emoji = {
            module = "blink-emoji",
            name = "Emoji",
            score_offset = -15,        -- Tune by preference
            max_items = 5,    -- Max number of emojis to show
            opts = { insert = true }, -- Insert emoji (default) or complete its name
          },
          avante = {
            module = 'blink-cmp-avante',
            name = 'Avante',
            opts = {
              -- options for blink-cmp-avante
            }
          },
          -- ripgrep = {
          --   module = "blink-ripgrep",
          --   name = "Ripgrep",
          --   -- the options below are optional, some default values are shown
          --   ---@module "blink-ripgrep"
          --   ---@type blink-ripgrep.Options
          --   opts = {}
          -- },
        },
        default = { 'lsp', 'path', 'snippets', 'buffer', 'references', 'lazydev', 'emoji', 'avante' },
      },

      -- See the fuzzy documentation for more information
      fuzzy = { implementation = "prefer_rust_with_warning" }
    },

    opts_extend = { "sources.default" }

  },
  {
    'hrsh7th/nvim-cmp',
    enabled = false,
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      { "hrsh7th/cmp-nvim-lsp-signature-help" },
      -- { "hrsh7th/cmp-calc" },
      { "saadparwaiz1/cmp_luasnip" },
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
    },
    config = function()
      -- [[ Configure nvim-cmp ]]
      -- See `:help cmp`

      local lspkind = require 'lspkind'

      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      ---@diagnostic disable-next-line missing-fields
      cmp.setup({
        completion = { completeopt = 'menu,menuone,noinsert', },
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
          -- ['<C-n>'] = cmp.mapping.select_next_item(),
          -- ['<C-p>'] = cmp.mapping.select_prev_item(),
          -- ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          -- ['<C-f>'] = cmp.mapping.scroll_docs(4),
          -- ['<C-Space>'] = cmp.mapping.complete(),
          -- ['<C-e>'] = cmp.mapping.close(),
          -- ['<CR>'] = cmp.mapping.confirm {
          --   behavior = cmp.ConfirmBehavior.Replace,
          --   select = true,
          -- },
          -- ['<Tab>'] = cmp.mapping(function(fallback)
          --   if cmp.visible() then
          --     cmp.select_next_item()
          --   elseif luasnip.expand_or_locally_jumpable() then
          --     luasnip.expand_or_jump()
          --   elseif has_words_before() then
          --     cmp.complete()
          --   else
          --     fallback()
          --   end
          -- end, { 'i', 's' }),
          -- ['<S-Tab>'] = cmp.mapping(function(fallback)
          --   if cmp.visible() then
          --     cmp.select_prev_item()
          --   elseif luasnip.locally_jumpable(-1) then
          --     luasnip.jump(-1)
          --   else
          --     fallback()
          --   end
          -- end, { 'i', 's' }),
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
