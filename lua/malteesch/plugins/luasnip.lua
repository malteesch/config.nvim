--- @type LazyPluginSpec
return {
    'L3MON4D3/LuaSnip',
    name = 'luasnip',
    lazy = true,
    config = function(_, opts)
        require('luasnip.loaders.from_vscode').lazy_load()
        require('luasnip.loaders.from_vscode').lazy_load { paths = './snippets' }
        require('luasnip.loaders.from_lua').lazy_load { paths = { './snippets' } }
        require('luasnip').config.setup(opts)
    end,
    dependencies = {
        'rafamadriz/friendly-snippets',
        'saadparwaiz1/cmp_luasnip',
        'comment'
    },
}
