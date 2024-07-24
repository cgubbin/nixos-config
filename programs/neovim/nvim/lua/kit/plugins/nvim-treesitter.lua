return {
	"nvim-treesitter/nvim-treesitter",
	enabled = true,
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
		"windwp/nvim-ts-autotag",
	},

	config = function()
		local treesitter = require("nvim-treesitter.configs")
		treesitter.setup({
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = true,
			},
			indent = {
				enable = true,
			},
			autotag = {
				enable = true,
			},
			ensure_installed = {
				"bash",
				"c",
				"cmake",
				"cpp",
				"csv",
				"elixir",
				"fish",
				"json",
				"lua",
				"markdown",
				"markdown_inline",
				"matlab",
				"nix",
				"python",
				"regex",
				"rust",
				"sql",
				"toml",
				"vim",
				"yaml",
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
		})
	end,
}
