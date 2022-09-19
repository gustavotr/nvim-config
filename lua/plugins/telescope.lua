local actions = require('telescope.actions')
local finders = require('telescope.builtin')

require('telescope').setup({
    defaults = {
        prompt_prefix = ' ❯ ',
        initial_mode = 'insert',
        sorting_strategy = 'ascending',
        layout_config = {
            prompt_position = 'top',
        },
        mappings = {
            i = {
                ['<ESC>'] = actions.close,
                ['<C-n>'] = actions.move_selection_next,
                ['<C-p>'] = actions.move_selection_previous,
                ['<TAB>'] = actions.toggle_selection + actions.move_selection_next,
                ['<C-s>'] = actions.send_selected_to_qflist,
                ['<C-q>'] = actions.send_to_qflist,
            },
        },
    },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = 'smart_case', -- "smart_case" | "ignore_case" | "respect_case"
        },
    },
    pickers = {
        colorscheme = {
            enable_preview = true
        }
    }
})

local Telescope = setmetatable({}, {
    __index = function(_, k)
        if vim.bo.filetype == 'NvimTree' then
            vim.cmd.wincmd('l')
        end
        return finders[k]
    end,
})

-- Ctrl-p = fuzzy finder
vim.keymap.set('n', '<leader>f', function()
    local ok = pcall(Telescope.git_files, { show_untracked = true })
    if not ok then
        Telescope.find_files()
    end
end)

-- Get :help at the speed of light
vim.keymap.set('n', '<leader>H', Telescope.help_tags)

-- Fuzzy find active buffers
vim.keymap.set('n', "<leader>sb", Telescope.buffers)

-- Search for string
vim.keymap.set('n', "<leader>st", Telescope.live_grep)

-- Fuzzy find changed files in git
vim.keymap.set('n', "<leader>go", Telescope.git_status)

-- Search recent files
vim.keymap.set('n', "<leader>sr", Telescope.oldfiles)

-- Search keymaps
vim.keymap.set('n', "<leader>sk", Telescope.keymaps)
