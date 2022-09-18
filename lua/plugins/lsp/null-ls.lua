local nls = require('null-ls')
local U = require('plugins.lsp.utils')

-- Configuring null-ls
nls.setup({
    sources = {
        ----------------
        -- FORMATTING --
       ----------------
        require('null-ls').builtins.formatting.trim_whitespace.with({
            filetypes = { 'text', 'zsh', 'toml', 'make', 'conf', 'tmux' },
        }),
        -- NOTE:
        -- 1. both needs to be enabled to so prettier can apply eslint fixes
        -- 2. prettierd should come first to prevent occassional race condition
        require('null-ls').builtins.formatting.prettierd,
        require('null-ls').builtins.formatting.eslint_d,
        -- require('null-ls').builtins.formatting.prettier.with({
        --     extra_args = {
        --         '--tab-width=4',
        --         '--trailing-comma=es5',
        --         '--end-of-line=lf',
        --         '--arrow-parens=always',
        --     },
        -- }),
        require('null-ls').builtins.formatting.rustfmt,
        require('null-ls').builtins.formatting.stylua,
        require('null-ls').builtins.formatting.gofmt,
        require('null-ls').builtins.formatting.zigfmt,
        require('null-ls').builtins.formatting.shfmt.with({
            extra_args = { '-i', 4, '-ci', '-sr' },
        }),
        -----------------
        -- DIAGNOSTICS --
        -----------------
        require('null-ls').builtins.diagnostics.eslint_d,
        require('null-ls').builtins.diagnostics.shellcheck,
        require('null-ls').builtins.diagnostics.luacheck.with({
            extra_args = { '--globals', 'vim', '--std', 'luajit' },
        }),
        ------------------
        -- CODE ACTIONS --
        ------------------
        require('null-ls').builtins.code_actions.eslint_d,
        require('null-ls').builtins.code_actions.shellcheck,
    },
    on_attach = function(client, bufnr)
        U.fmt_on_save(client, bufnr)
        U.mappings(bufnr)
    end,
})
