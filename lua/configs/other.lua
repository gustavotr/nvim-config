require("other-nvim").setup({
	showMissingFiles = false,
	mappings = {
		"golang",
		{
			context = "implementation",
			pattern = "(.*)%.test%.([^.]+)$",
			target = "%1.%2",
		},
		{
			context = "implementation",
			pattern = "(.*)%.integration%.test%.([^.]+)$",
			target = "%1.%2",
		},
		{
			context = "test",
			pattern = "(.*)%.([^.]+)$",
			target = "%1.test.%2",
		},
		{
			context = "test",
			pattern = "(.*)%.([^.]+)$",
			target = "%1.integration.test.%2",
		},
	},
})
