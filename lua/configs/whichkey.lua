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
}, { prefix = "<leader>" })
