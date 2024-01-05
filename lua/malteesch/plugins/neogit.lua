return {
    'NeogitOrg/neogit',
    dependencies = {
        'plenary',
        'sindrets/diffview.nvim',
        'telescope',
    },
    opts = {},
    -- stylua: ignore
    keys = {
        { '<leader>gg', function() require("neogit").open() end, desc = "Open Neo[g]it" }
    }
}
