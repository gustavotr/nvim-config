require("mason").setup()
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")

mason_lspconfig.setup({
	ensure_installed = {
		"lua_ls",
		"rust_analyzer",
		"tsserver",
		"angularls",
		"yamlls",
		"jsonls",
		"gopls",
		"phpactor",
	},
	automatic_installation = true,
})

local function lsp_keymaps(bufnr)
	local keymap = vim.api.nvim_buf_set_keymap
	keymap(
		bufnr,
		"n",
		"gD",
		"<cmd>lua vim.lsp.buf.declaration()<CR>",
		{ noremap = true, silent = true, desc = "Go to declaration" }
	)
	keymap(
		bufnr,
		"n",
		"gd",
		"<cmd>lua vim.lsp.buf.definition()<CR>",
		{ noremap = true, silent = true, desc = "Go to definition" }
	)
	keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { noremap = true, silent = true, desc = "LSP Hover" })
	keymap(
		bufnr,
		"n",
		"gI",
		"<cmd>lua vim.lsp.buf.implementation()<CR>",
		{ noremap = true, silent = true, desc = "Go to implementation" }
	)
	keymap(
		bufnr,
		"n",
		"gr",
		"<cmd>lua vim.lsp.buf.references()<CR>",
		{ noremap = true, silent = true, desc = "Go to references" }
	)
	keymap(
		bufnr,
		"n",
		"gl",
		"<cmd>lua vim.diagnostic.open_float()<CR>",
		{ noremap = true, silent = true, desc = "Line diagnostics" }
	)
	keymap(
		bufnr,
		"n",
		"<leader>lf",
		"<cmd>lua vim.lsp.buf.format()<cr>",
		{ noremap = true, silent = true, desc = "Format" }
	)
	keymap(bufnr, "n", "<leader>li", "<cmd>LspInfo<cr>", { noremap = true, silent = true, desc = "LspInfo" })
	keymap(
		bufnr,
		"n",
		"<leader>lI",
		"<cmd>LspInstallInfo<cr>",
		{ noremap = true, silent = true, desc = "LspInstallInfo" }
	)
	keymap(
		bufnr,
		"n",
		"<leader>la",
		"<cmd>lua vim.lsp.buf.code_action()<cr>",
		{ noremap = true, silent = true, desc = "Code action" }
	)
	keymap(
		bufnr,
		"n",
		"<leader>lj",
		"<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>",
		{ noremap = true, silent = true, desc = "Next buffer" }
	)
	keymap(
		bufnr,
		"n",
		"<leader>lk",
		"<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>",
		{ noremap = true, silent = true, desc = "Prev buffer" }
	)
	keymap(
		bufnr,
		"n",
		"<leader>lr",
		"<cmd>lua vim.lsp.buf.rename()<cr>",
		{ noremap = true, silent = true, desc = "Rename" }
	)
	keymap(
		bufnr,
		"n",
		"<leader>ls",
		"<cmd>lua vim.lsp.buf.signature_help()<CR>",
		{ noremap = true, silent = true, desc = "Signature help" }
	)
	keymap(
		bufnr,
		"n",
		"<leader>lq",
		"<cmd>lua vim.diagnostic.setloclist()<CR>",
		{ noremap = true, silent = true, desc = "Diag. setloclist" }
	)
end

local on_attach = function(client, bufnr)
	if client.name == "tsserver" then
		client.server_capabilities.document_formatting = false
	end

	if client.name == "sumneko_lua" then
		client.server_capabilities.document_formatting = false
	end

	lsp_keymaps(bufnr)

	local status_ok, illuminate = pcall(require, "illuminate")
	if not status_ok then
		return
	end
	illuminate.on_attach(client)
end

mason_lspconfig.setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup({
			on_attach = on_attach,
		})
	end,
	["gopls"] = function()
		lspconfig.gopls.setup({
			on_attach = on_attach,
			settings = {
				gopls = {
					completeUnimported = true,
					usePlaceholders = true,
					analyses = {
						unusedparams = true,
					},
				},
			},
		})
	end,

	["phpactor"] = function()
		lspconfig.phpactor.setup({
			on_attach = on_attach,
			root_dir = lspconfig.util.root_pattern("composer.json", ".git", "wp-config.php"),
		})
	end,
})

local signs = {

	{ name = "DiagnosticSignError", text = "" },
	{ name = "DiagnosticSignWarn", text = "" },
	{ name = "DiagnosticSignHint", text = "" },
	{ name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
	vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

local config = {
	virtual_text = true, -- disable virtual text
	signs = {
		active = signs, -- show signs
	},
	update_in_insert = true,
	underline = true,
	severity_sort = true,
	float = {
		focusable = true,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
}

vim.diagnostic.config(config)

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = "rounded",
})
