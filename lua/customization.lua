local function get_icon(file)
    local ok, icons = pcall(require, "nvim-web-devicons")
    if not ok then
        return ""
    end
    local fname = vim.fn.fnamemodify(file, ":t")
    local ext = vim.fn.fnamemodify(file, ":e")
    return icons.get_icon(fname, ext, { default = true })
end

vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError", numhl = "" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn", numhl = "" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint", numhl = "" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo", numhl = "" })
vim.cmd('hi DiagnosticError guifg=DarkRed')
vim.cmd('hi DiagnosticWarn guifg=DarkYellow')
vim.cmd('hi DiagnosticInfo guifg=Blue')
vim.cmd('hi DiagnosticHint guifg=Green')
