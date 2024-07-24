return {
    -- Use `yow` to toggle wrapping mode
    "andrewferrier/wrapping.nvim",
    enabled = true,
    lazy = false,
    config = function()
        require("wrapping").setup()
    end
}
