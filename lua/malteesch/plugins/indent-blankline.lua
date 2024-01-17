--- @type LazyPluginSpec
return {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
        indent = {
            char = '▏',
        },
        scope = {
            show_start = false,
        },
    },
}
