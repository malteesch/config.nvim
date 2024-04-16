vim.keymap.set('n', '<leader>f', function()
    local cursor = vim.api.nvim_win_get_cursor(0)
    vim.cmd [[
        %!jq .
    ]]
    vim.api.nvim_win_set_cursor(0, cursor)
end, { noremap = true, silent = true, desc = 'Format with jq' })
