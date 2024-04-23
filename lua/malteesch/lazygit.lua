local function open_from_lazygit(cmd_opts)
    if #cmd_opts.fargs == 2 then
        vim.cmd('edit +' .. cmd_opts.fargs[2] .. ' ' .. cmd_opts.fargs[1])
    else
        vim.cmd('edit ' .. cmd_opts.fargs[1])
    end
end

local lazygit_config_files = {
    vim.fn.stdpath 'config' .. '/configs/lazygit.yml',
    '$HOME/.config/lazygit/config.yml',
}

vim.keymap.set('n', '<leader>lg', function()
    vim.fn.system {
        'tmux',
        'display-popup',
        '-E',
        '-w90%',
        '-h90%',
        string.format('-eNVIM_SERVER_NAME=%s', vim.v.servername),
        'lazygit --use-config-file ' .. table.concat(lazygit_config_files, ','),
    }
end)

vim.api.nvim_create_user_command('OpenFromLazyGit', open_from_lazygit, { nargs = '+' })
