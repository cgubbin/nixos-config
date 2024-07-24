return {
	"nvim-neo-tree/neo-tree.nvim",
	enabled = true,
	cmd = "Neotree",
	branch = "v2.x",
	keys = {
		{ "<leader>nt", "<cmd>Neotree toggle<cr>", desc = "Neotree" },
		-- { "<leader>pv", "<cmd>Neotree toggle current<cr>", desc = "Neotree" },
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
	opts = {
		filesystem = {
			follow_current_file = true,
			hijack_netrw_behavior = "open_default",
		},
	},
}
