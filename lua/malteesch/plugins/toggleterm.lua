--- @type LazyPluginSpec
return {
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {
        open_mapping = [[<C-\>]],
        direction = 'horizontal',
        size = 30,
        autochdir = true,
        float_opts = {
            border = 'curved',
        },
    },
    cmd = { 'ToggleTerm' },
    -- stylua: ignore
    keys = {
        { [[<C-\>]] },
        { '<leader>lg',
            function()
                local Terminal = require('toggleterm.terminal').Terminal
                local lazygit = Terminal:new {
                    cmd = 'lazygit',
                    dir = vim.fn.getcwd(0),
                    direction = 'float',
                    hidden = true,
                    env = {
                        NVIM_SERVER_NAME = vim.v.servername
                    }
                }:toggle()
                vim.api.nvim_create_user_command('OpenFromLazyGit', function(opts)
                    lazygit:close()
                    vim.cmd.edit(opts.args)
                end, {
                    nargs = 1
                })
            end,
            desc = "[L]azy[g]it"
        },
    },
}
