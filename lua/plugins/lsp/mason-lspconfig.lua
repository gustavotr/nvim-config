require('mason-lspconfig').setup{
    automatic_instalation=true,
        ensure_installed = {
"jsonls",
"tsserver",
  "sumneko_lua",
  "rust_analyzer",
  "angularls",
    }
}
