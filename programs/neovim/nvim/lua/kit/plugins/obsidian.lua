return {
	"epwalsh/obsidian.nvim",
	enabled = false,
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = true,
	-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
	event = {
		-- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
		-- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
		"BufReadPre ~/obsidian/main/main/**.md",
		"BufNewFile ~/obsidian/main/main/**.md",
	},
	dependencies = {
		-- Required.
		"nvim-lua/plenary.nvim",

		-- see below for full list of optional dependencies 👇
	},
	opts = {
		workspaces = {
			{
				name = "main",
				path = "~/obsidian/main/main",
			},
		},

		-- see below for full list of options 👇
	},
}
