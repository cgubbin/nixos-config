return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	name = "tokyonight",
	config = function(LazyPlugin)
		vim.cmd("colorscheme tokyonight-night")
	end,
}
