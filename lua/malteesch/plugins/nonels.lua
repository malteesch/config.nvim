--- @type LazyPluginSpec
return {
    'nvimtools/none-ls.nvim',
    config = function()
        local null_ls = require 'null-ls'

        null_ls.setup {
            sources = {
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.diagnostics.yamllint
            },
        }
    end,
    dependencies = {
        {
            'WhoIsSethDaniel/mason-tool-installer.nvim',
            opts = {
                ensure_installed = {
                    'stylua',
                    'yamllint',
                },
            },
            dependencies = {
                'williamboman/mason.nvim',
            },
        },
    },
}
