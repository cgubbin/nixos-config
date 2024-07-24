return {
    "lervag/vimtex",
    ft = "tex",
    config = function()
	vim.g.tex_flavor = "latex"
    	vim.g.vimtex_view_method = "zathura"
	vim.g.vimtex_view_general_viewer = "zathura"
    	vim.g.vimtex_view_forward_search_on_start = false
	vim.g.vimtex_imaps_enabled = 0
    	vim.g.vimtex_quickfix_mode = 0
	vim.o.conceallevel = 1
    	vim.g.tex_conceal = "abdmg"
	vim.g.UltiSnipsExpandTrigger = "<tab>"
	vim.g.UltiSnipsJumpForwardTrigger = "<tab>"
	vim.g.UltiSnipsJumpBackwardTrigger = "<s-tab>"
    end,
}
