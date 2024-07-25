local map_opts = { noremap = true, silent = true, nowait = true, buffer = true }
return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        -- { "nvim-telescope/telescope-fzf-native.nvim", build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release" },
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        local state = require("telescope.actions.state")
        local u = require("kit.functions.utils")
        local builtin = require("telescope.builtin")

        local function find_matching_files()
            local bare_file_name = u.return_bare_file_name()
            require("telescope.builtin").find_files({ default_text = bare_file_name })
        end

        -- Functions for telescope
        local function live_grep()
            builtin.live_grep()
        end

        local function git_files()
            local ok = pcall(builtin.git_files)
            if not ok then
                require("telescope.builtin").find_files()
            end
        end

        local function git_commits()
            builtin.git_commits()
        end

        local function git_branches()
            builtin.git_branches()
        end

        local function grep_string()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string()
            vim.api.nvim_feedkeys(word, "i", false)
        end

        local function SeeCommitChangesInDiffview(prompt_bufnr)
            actions.close(prompt_bufnr)
            local value = state.get_selected_entry().value
            vim.cmd("DiffviewOpen " .. value .. "~1.." .. value)
        end

        local function CompareWithCurrentBranchInDiffview(prompt_bufnr)
            actions.close(prompt_bufnr)
            local value = state.get_selected_entry().value
            vim.cmd("DiffviewOpen " .. value)
        end

        local function CopyTextFromPreview(prompt_bufnr)
            local selection = require("telescope.actions.state").get_selected_entry()
            local text = vim.fn.trim(selection["text"])
            local os = u.get_os() == "Darwin" and "mac" or "linux"
            if os == "mac" then
                vim.fn.setreg("*", text)
            else
                vim.fn.setreg('"', text)
            end
            actions.close(prompt_bufnr)
        end

        local function CopyCommitHash(prompt_bufnr)
            local selection = require("telescope.actions.state").get_selected_entry()
            local os = u.get_os() == "Darwin" and "mac" or "linux"
            if os == "mac" then
                vim.fn.setreg("*", selection.value)
            else
                vim.fn.setreg('"', selection.value)
            end
            actions.close(prompt_bufnr)
        end

        local function SendToQuickfix(bufnr)
            actions.smart_add_to_qflist(bufnr)
            actions.open_qflist(bufnr)
        end

        local function OpenInOil()
            local selection = require("telescope.actions.state").get_selected_entry()
            require("plugins.oil").open_dir(selection.value)
        end

        telescope.setup({
            defaults = {
                border = true,
                layout_stategy = "horizontal",
                mappings = {
                    i = {
                        ["<C-k>"] = actions.move_selection_previous, -- move to previous result
                        ["<C-j>"] = actions.move_selection_next,     -- move to next result
                        -- send selected results to the quickfix list
                        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                    },
                },
            },
        })

        -- telescope.load_extension("fzf")

        --     local keymap = vim.keymap
        --
        --     keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
        --     keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
        --     keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
        --     keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
    end,
}
