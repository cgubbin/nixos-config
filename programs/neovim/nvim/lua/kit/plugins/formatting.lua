return {
	"stevearc/conform.nvim",
	enabled = true,
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				cpp = { "clang_format" },
				elixir = { "mix" },
				json = { "jq" },
				lua = { "stylua" },
				markdown = { "mdformat" },
				python = { "ruff_fix", "ruff_format" },
				rust = { "rustfmt" },
				sql = { "sql_formatter" },
				tex = { "latexindent" },
				toml = { "taplo" },
				yaml = { "yamlfmt" },
				zig = { "zigfmt" },
			},
			format_on_save = {
				lsp_fallback = true,
				async = false, -- Formatting is not asynchronous
				timeout_ms = 500,
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 500,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
