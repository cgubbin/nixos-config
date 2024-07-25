return {
    setup = function(dap)
        dap.adapers.codelldb = {
            type = "server",
            host = "127.0.0.1",
            port = "${port}",
            -- executable = {
            --     command = vim.fn.stdpath("data") ..,
            --     args = { "--port", "${port}" },
            -- },
        }
    end,
}
