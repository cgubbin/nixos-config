return {
    {
        "mfussenegger/nvim-dap",
        -- lazy = true,
        dependencies = {
            { "rcarriga/nvim-dap-ui" },
            { "nvim-neotest/nvim-nio" },
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            local adapters = require("kit.plugins.dap.adapters")
            local configurations = require("kit.plugins.dap.config")

            adapters.setup(dap)
            configurations.setup(dap)


            dap.set_log_level("INFO")

            dapui.setup({
                icons = { expanded = "▾", collapsed = "▸" },
                mappings = {
                    open = "o",
                    remove = "d",
                    edit = "e",
                    repl = "r",
                    toggle = "t",
                },
                expand_lines = vim.fn.has("nvim-0.7"),
                layouts = {
                    {
                        elements = {
                            "scopes",
                        },
                        size = 0.3,
                        position = "right",
                    },
                    {
                        elements = {
                            "repl",
                            "breakpoints",
                        },
                        size = 0.3,
                        position = "bottom",
                    }, },
                floating = {
                    max_height = nil,
                    max_width = nil,
                    border = "single",
                    mappings = {
                        close = { "q", "<Esc>" },
                    },
                },
                windows = { indent = 1 },
                render = {
                    max_type_length = nil,
                },
            })

            vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "Error" })

            vim.keymap.set("n", "<leader>ds", function()
                dap.continue()
                dapui.toggle({})
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false) -- buffers spaces evenly
            end)

            vim.keymap.set("n", "<leader>dl", require("dap.ui.widgets").hover)
            vim.keymap.set("n", "<leader>dc", dap.continue)
            vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
            vim.keymap.set("n", "<leader>dn", dap.step_over)
            vim.keymap.set("n", "<leader>di", dap.step_into)
            vim.keymap.set("n", "<leader>do", dap.step_out)
            vim.keymap.set("n", "<leader>dC", function()
                dap.clear_breakpoints()
                require("notify")("Breakpoints cleared", "warn", { title = "Dap" })
            end)

            -- close and clear
            vim.keymap.set("n", "<leader>de", function()
                dap.clear_breakpoints()
                dapui.toggle({})
                dap.terminate()
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false) -- buffers spaces evenly
                require("notify").notify("DAP Session Ended", "warn", { title = "Dap" })
            end)
        end,

    },
}
