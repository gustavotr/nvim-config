require('toggleterm').setup{
    size = function(term)
        if term.direction == 'horizontal' then
            return 12
        elseif term.direction == 'vertiacal' then
            return 40
        end
    end
}

vim.keymap.set('n', '<C-t>', '<CMD>ToggleTerm<CR>')
