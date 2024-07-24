return {
	"robitx/gp.nvim",
	config = function()
		local conf = {
			providers = {
				anthropic = {
					disable = false,
					endpoint = "https://api.anthropic.com/v1/messages",
					secret = os.getenv("ANTHROPIC_API_KEY"),
				},
			},
			cmd_prefix = "Gp",
		}
		require("gp").setup(conf)

		-- or setup with your own config (see Install > Configuration in Readme)
		-- require("gp").setup(config)

		-- shortcuts might be setup here (see Usage > Shortcuts in Readme)
	end,
}
