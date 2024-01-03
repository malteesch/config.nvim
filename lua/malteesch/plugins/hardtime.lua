--- @type LazyPluginSpec
return {
    'm4xshen/hardtime.nvim',
    dependencies = { 'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim' },
    opts = {
        disabled_filetypes = { 'qf', 'netrw', 'neo-tree', 'lazy', 'mason', 'query', 'help', 'noice', 'messages' },
    },
}
