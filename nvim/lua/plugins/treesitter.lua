return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	lazy = false,
	dependencies = {
		"windwp/nvim-ts-autotag",
	},
	config = function()
		require("nvim-treesitter").install({
			"tsx",
			"typescript",
			"javascript",
			"toml",
			"json",
			"yaml",
			"html",
			"scss",
			"css",
			"lua",
			"vim",
			"dockerfile",
			"dot",
			"scss",
			"bash",
			"c_sharp",
			"vue",
			"hcl",
			"markdown",
			"markdown_inline",
			"java",
		})
	end,
}
