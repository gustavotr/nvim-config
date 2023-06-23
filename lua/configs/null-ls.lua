local null_ls = require("null-ls")

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local on_attach = function(client, bufnr)
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({ bufnr = bufnr })
			end,
		})
	end
end

null_ls.setup({
	debug = true,
	sources = {
		null_ls.builtins.code_actions.eslint_d,
		null_ls.builtins.formatting.prettierd,
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.gofumpt,
		null_ls.builtins.formatting.goimports,
		null_ls.builtins.formatting.goimports_reviser,
		null_ls.builtins.formatting.golines,
		null_ls.builtins.formatting.prismaFmt,
		null_ls.builtins.formatting.phpcsfixer,
		null_ls.builtins.diagnostics.codespell,
		null_ls.builtins.diagnostics.eslint_d,
		null_ls.builtins.diagnostics.jsonlint,
		null_ls.builtins.diagnostics.markdownlint,
		null_ls.builtins.diagnostics.yamllint,
		null_ls.builtins.diagnostics.tsc,
		null_ls.builtins.diagnostics.php,
	},
	on_attach = on_attach,
})
