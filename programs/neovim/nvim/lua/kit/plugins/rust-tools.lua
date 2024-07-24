return {
	-- "simrat39/rust-tools.nvim",
	"mrcjkb/rustaceanvim",
	-- "simrat39/rust-tools.nvim",
	--
	enabled = true,
	version = "^4",
	ft = { "rust" },
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"neovim/nvim-lspconfig",
	},
	-- config = function()
	-- 	-- local rt = require("rust-tools")
	-- 	local rt = require("rustaceanvim")
	-- 	rt.setup({
	-- 		server = {
	-- 			on_attach = function(_, bufnr)
	-- 				-- Hover actions
	-- 				vim.keymap.set("n", "<C-h>", rt.hover_actions.hover_actions, { buffer = bufnr })
	-- 				-- Code action groups
	-- 				vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
	-- 			end,
	-- 		},
	-- 	})
	-- end,
}
