local wk = require("which-key")
-- As an example, we will create the following mappings:
--  * <leader>ff find files
--  * <leader>fr show recent files
--  * <leader>fb Foobar
-- we'll document:
--  * <leader>fn new file
--  * <leader>fe edit file
-- and hide <leader>1

wk.register({
  f = {
    name = "+find", -- optional group name
  },
  g = {
    name = "+git",
    v = {
      name = "+diffview",
    },
  },
  l = {
    name = "+lsp",
  },
  n = {
    name = "+navigation",
    a = { "<cmd>lua require('harpoon.mark').add_file()<cr>", "harpoon add file" },
    r = { "<cmd>lua require('harpoon.mark').rm_file()<cr>", "harpoon remove file" },
    m = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", "harpoon menu" },
    n = { "<cmd>lua require('harpoon.ui').nav_next()<cr>", "harpoo next file" },
    p = { "<cmd>lua require('harpoon.ui').nav_prev()<cr>", "harpoon previous file" },
    o = { "<cmd>Other<cr>", "other file" },
    ["1"] = { "<cmd> lua require('harpoon.ui').nav_file(1)<cr>", "file 1" },
    ["2"] = { "<cmd> lua require('harpoon.ui').nav_file(2)<cr>", "file 2" },
    ["3"] = { "<cmd> lua require('harpoon.ui').nav_file(3)<cr>", "file 3" },
    ["4"] = { "<cmd> lua require('harpoon.ui').nav_file(3)<cr>", "file 4" },
    ["5"] = { "<cmd> lua require('harpoon.ui').nav_file(3)<cr>", "file 5" },
    ["6"] = { "<cmd> lua require('harpoon.ui').nav_file(3)<cr>", "file 6" },
    ["7"] = { "<cmd> lua require('harpoon.ui').nav_file(3)<cr>", "file 7" },
    ["8"] = { "<cmd> lua require('harpoon.ui').nav_file(3)<cr>", "file 8" },
    ["9"] = { "<cmd> lua require('harpoon.ui').nav_file(3)<cr>", "file 9" },
  },
}, { prefix = "<leader>" })
