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
    init = function()
        local Terminal = require('toggleterm.terminal').Terminal
        local lazygit = Terminal:new({
            cmd = 'lazygit',
            dir = vim.fn.getcwd(0),
            direction = 'float',
            hidden = true,
            env = {
                NVIM_SERVER_NAME = vim.v.servername,
            },
            on_open = function (term)
                vim.keymap.set('t', 'q', function() term:toggle() end, { buffer = term.bufnr })
            end
        })
        lazygit:spawn()

        vim.api.nvim_create_user_command('OpenFromLazyGit', function(cmd_opts)
            lazygit:toggle()
            vim.cmd.edit(cmd_opts.args)
        end, { nargs = 1 })

        vim.keymap.set('n', '<leader>lg', function() lazygit:toggle() end, { desc = '[L]azy[g]it' })
    end
}
