--- @type LazyPluginSpec
return {
    'willothy/wezterm.nvim',
    opts = {
        create_commands = false,
    },
    init = function()
        local wt = require 'wezterm'

        local wezterm_group = vim.api.nvim_create_augroup('Wezterm', { clear = true })
        vim.api.nvim_create_autocmd({ 'VimEnter', 'DirChanged' }, {
            callback = function()
                local pane_id = wt.get_current_pane()
                if pane_id == nil then
                    return
                end
                local new_cwd = vim.fn.getcwd()
                wt.exec(
                    { 'cli', 'send-text', '--no-paste', '--pane-id', string.format('%d', pane_id + 1), string.format('cd %s\nclear\n', new_cwd) },
                    function() end
                )
            end,
            group = wezterm_group,
            pattern = '*',
        })
    end,
}
