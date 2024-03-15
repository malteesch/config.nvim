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
                local new_cwd = vim.fn.getcwd()
                local tab_id = vim.fn.system("kitten @ ls | jq '.[].tabs | map(select(.is_active == true)) | first | .id'")
                vim.fn.system(string.format("kitten @ --to $KITTY_LISTEN_ON send-text --match='title:^toggle-%s$' 'cd %s\n'", string.gsub(tab_id, "\n", ""), new_cwd))
                vim.fn.system(string.format("kitten @ --to $KITTY_LISTEN_ON send-key --match='title:^toggle-%s$' 'ctrl+l'", string.gsub(tab_id, "\n", "")))
            end,
            group = wezterm_group,
            pattern = '*',
        })
    end,
}
