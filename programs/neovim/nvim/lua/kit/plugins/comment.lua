return {
	"numToStr/Comment.nvim",
	enabled = false,
	event = { "BufReadPre", "BufNewFile" },
	config = true, -- runs require('Comment').setup()
}
