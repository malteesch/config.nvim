--- @type LazyPluginSpec
return {
    'stevearc/oil.nvim',
    opts = {
        default_file_explorer = true,
        delete_to_trash = true,
        keymaps = {
            q = 'actions.close',
            H = 'actions.toggle_hidden',
            ['?'] = 'actions.show_help',
        },
        view_options = {
            show_hidden = true,
        },
        float = {
            max_width = 80,
            max_height = 40,
        },
    },
    keys = {
        -- stylua: ignore start
        { '<leader>fo', function() require("oil").open_float() end, desc = '[o]pen' },
        -- stylua: ignore end
    },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
}
