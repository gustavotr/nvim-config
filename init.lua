-- Vanilla Config
require('settings')
require('autocmd')
require('plugins')
require('keybinds')

---Pretty print lua table
function _G.dump(...)
    local objects = vim.tbl_map(vim.inspect, { ... })
    print(unpack(objects))
end
