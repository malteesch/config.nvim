return {
    'sindrets/diffview.nvim',
    name = 'diffview',
    keys = {
        -- stylua: ignore start
        { '<leader>gc', function() require('diffview').open {} end, desc = '[c]hanges', },
        -- stylua: ignore end
    },
    opts = {
        hooks = {
            --- @param view View
            view_opened = function(view)
                vim.keymap.set('n', 'q', function()
                    view:close()
                end)
            end,
        },
    },
}
