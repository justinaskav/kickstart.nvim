-- Copied from https://github.com/AdrielVelazquez/nixos-config/blob/testing-new-neovim-lsp/dotfiles/sample-lsp-config/lua/config/lsp.lua
vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP actions",
	callback = function(event)
		local nmap = function(keys, func, desc)
			if desc then
				desc = 'LSP: ' .. desc
			end

			vim.keymap.set('n', keys, func, { buffer = event.buf, desc = desc })
		end

		nmap('K', vim.lsp.buf.hover, '[H]over Documentation')
		nmap('<leader>dc', vim.lsp.buf.rename, '[R]ename')
		nmap('<leader>da', vim.lsp.buf.code_action, 'Code [A]ction')

		nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
		nmap('<leader>dr', require('telescope.builtin').lsp_references, 'Go To [R]eferences')
		nmap('<leader>dI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
		nmap('<leader>dd', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
		nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, 'Document [S]ymbols')
		vim.keymap.set('n', '<leader>dq', function() require("trouble").toggle("quickfix") end,
			{ desc = 'Trouble: Open [Q]uickfix' })
		vim.keymap.set('n', '<leader>dl', function() require("trouble").toggle("workspace_diagnostics") end,
			{ desc = 'Trouble: Open [L]ist of diagnostics' })
		-- No need for document symbols
		-- nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

		-- See `:help K` for why this keymap
		-- nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
		nmap('<leader>dk', vim.lsp.buf.signature_help, 'Signature Documentation')

		-- Lesser used LSP functionality
		-- nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
		-- nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
		-- nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
		-- nmap('<leader>wl', function()
		--   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		-- end, '[W]orkspace [L]ist Folders')

		-- Create a command `:LspFormat` local to the LSP buffer
		vim.api.nvim_buf_create_user_command(event.buf, 'LspFormat', function(_)
			vim.lsp.buf.format()
		end, { desc = 'Format current buffer with LSP' })

		require("which-key").add({
			{ '<leader>d',  group = '[D]ocument' },
			{ '<leader>d_', hidden = true }
		})
		-- vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
		-- vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
		-- vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
		-- vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
		-- vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
		-- vim.keymap.set("n", "gc", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
		-- vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
		-- vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
	end,
})

-- This is copied straight from blink
-- https://cmp.saghen.dev/installation#merging-lsp-capabilities
local capabilities = {
	textDocument = {
		foldingRange = {
			dynamicRegistration = false,
			lineFoldingOnly = true,
		},
	},
}

capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

-- Setup language servers.
vim.lsp.config("*", {
	capabilities = capabilities,
	root_markers = { ".git" },
})

-- Merge tables

local function merge_tables(t1, t2)
	local merged = {}
	for k, v in pairs(t1) do
		merged[k] = v
	end
	for k, v in pairs(t2) do
		merged[k] = v
	end
	return merged
end

local lsps = {
	"astro-language-server",
	"bash-language-server",
	"css-lsp",
	"eslint-lsp",
	"html-lsp",
	"intelephense",
	"json-lsp",
	"lua-language-server",
	"marksman",
	"pyright",
	"r-languageserver",
	"ruff",
	"tailwindcss-language-server",
	"tinymist",
	"typescript-language-server",
	"vue-language-server",
	"yaml-language-server",
}

local formatters = {
	"pint"
}

require('mason-tool-installer').setup { ensure_installed = merge_tables(lsps, formatters) }

-- Enable each language server by filename under the lsp/ folder
vim.lsp.enable(lsps)
