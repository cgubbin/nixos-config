return {
    'VonHeikemen/lsp-zero.nvim',
    config = function()
        local lsp = require('lsp-zero')
        -- local lsp_zero_config = {call_servers = "global"}
        -- local lsp_servers = {'lua_ls'}
        -- local lua_ls_config = {
        --     settings = {
        --         Lua = {
        --             diagnostics = {globals = {'vim'}},
        --             runtime = {version = 'LuaJIT'},
        --             telemetry = {enable = false},
        --         },
        --     },
        -- }
        --
        -- local function on_attach(_, bufnr)
        --     -- omitted for now...
        -- end
        --
        -- -- local diagnostics_config = {
        -- --     -- omited for now...
        -- -- }
        -- lsp.set_preferences(lsp_zero_config)
        -- lsp.configure('lua_ls', lua_ls_config)
        -- lsp.setup_servers(lsp_servers)
        -- lsp.on_attach(on_attach)
        lsp.setup()
        -- vim.diagnostic.config(diagnostics_config)
    end,
    dependencies = {
    {'neovim/nvim-lspconfig'},
    },
}
