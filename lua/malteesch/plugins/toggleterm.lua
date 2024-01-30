--- @param term Terminal
--- @param git_root string?
--- @return fun(cmd_opts: table)
local function open_from_lazygit(term, git_root)
    return function(cmd_opts)
        term:toggle()
        if #cmd_opts.fargs == 2 then
            vim.cmd('edit +' .. cmd_opts.fargs[2] .. ' ' .. git_root .. '/' .. cmd_opts.fargs[1])
        else
            vim.cmd('edit ' .. git_root .. '/' .. cmd_opts.fargs[1])
        end
    end
end

local lazygit_config_files = {
    vim.fn.stdpath 'config' .. '/configs/lazygit.yml',
    '/home/malteesch/.config/lazygit/config.yml',
}

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
        vim.schedule(function()
            local Terminal = require('toggleterm.terminal').Terminal
            local git_root = require('malteesch.util').find_git_root()
            local lazygit = Terminal:new {
                cmd = 'lazygit --use-config-file ' .. table.concat(lazygit_config_files, ','),
                dir = vim.fn.getcwd(0),
                direction = 'float',
                hidden = true,
                env = {
                    NVIM_SERVER_NAME = vim.v.servername,
                },
                on_open = function(term)
                    -- stylua: ignore
                    vim.keymap.set('t', 'q', function() term:toggle() end, { buffer = term.bufnr })
                end,
            }
            lazygit:spawn()

            vim.api.nvim_create_user_command('OpenFromLazyGit', open_from_lazygit(lazygit, git_root), { nargs = '+' })

            -- stylua: ignore
            vim.keymap.set('n', '<leader>lg', function() lazygit:toggle() end, { desc = '[L]azy[g]it' })
        end)
    end,
}
