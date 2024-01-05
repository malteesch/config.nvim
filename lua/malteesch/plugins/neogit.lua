return {
    'NeogitOrg/neogit',
    dependencies = {
        'plenary',
        'telescope',
        'diffview',
    },
    event = { 'BufEnter' },
    keys = {
        -- stylua: ignore start
        { '<leader>gg',  function() require('neogit').open() end, desc = 'Open Neo[g]it' },
        { '<leader>gfh', function() require("diffview").file_history(nil, { '%' }) end, desc = '[f]ile [h]istory' },
        -- stylua: ignore end
    },
    opts = {},
}
