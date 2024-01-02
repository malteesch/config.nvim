--- @type LazyPluginSpec
return {
    "nvimtools/none-ls.nvim",
    config = function ()
        local null_ls = require("null-ls")

        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.stylua
            }
        })
    end,
    dependencies = {
        {
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            opts = {
                ensure_installed = {
                    "stylua"
                }
            },
            dependencies = {
                'williamboman/mason.nvim'
            }
        }
    }
}

