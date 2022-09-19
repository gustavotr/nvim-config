require('lualine').setup({
    options = {
        theme = 'auto',
        component_separators = '',
        section_separators = '',
        icons_enabled = true,
        globalstatus = true,
    },
    sections = {
        lualine_a = {
            { 'mode', color = { gui = 'bold' } },
        },
        lualine_b = {
            { 'branch' },
            { 'diff', colored = false },
        },
        lualine_c = {
            { 'filename', file_status = true },
        },
        lualine_x = {
            'diagnostics',
            'filetype',
            'encoding',
            'fileformat',
        },
        lualine_y = { 'progress' },
        lualine_z = {
            "os.date('%X')", 'data', "require'lsp-status'.status()"
        },
    },
    tabline = {
        lualine_a = {
            {
                'buffers',
                buffers_color = { active = 'lualine_b_normal' },
            },
        },
        lualine_z = {
            {
                'tabs',
                tabs_color = { active = 'lualine_b_normal' },
            },
        },
    },
    extensions = { 'quickfix', 'nvim-tree' },
})
