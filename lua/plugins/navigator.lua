require('Navigator').setup({
    auto_save = 'current',
})

vim.keymap.set('n', '<C-h>', '<CMD>lua require("Navigator").left()<CR>')
vim.keymap.set('n', '<C-k>', '<CMD>lua require("Navigator").up()<CR>')
vim.keymap.set('n', '<C-l>', '<CMD>lua require("Navigator").right()<CR>')
vim.keymap.set('n', '<C-j>', '<CMD>lua require("Navigator").down()<CR>')
