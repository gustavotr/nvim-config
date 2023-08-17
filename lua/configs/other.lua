require("other-nvim").setup({
	mappings = {
		"golang",
		{
			context = "implementation",
			pattern = "(.*)%.test%.([^.]+)$",
			target = "%1.%2",
		},
		{
			context = "test",
			pattern = "(.*)%.([^.]+)$",
			target = "%1.test.%2",
		},
	},
})
