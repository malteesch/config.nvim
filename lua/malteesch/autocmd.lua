-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

local toggle_pane_group = vim.api.nvim_create_augroup('TogglePaneDirChange', { clear = true })
vim.api.nvim_create_autocmd({ 'VimEnter', 'DirChanged' }, {
    callback = function()
        local new_cwd = vim.fn.getcwd()
        vim.fn.system(string.format("tmux send-keys -t 2 'cd %s' Enter C-l", new_cwd))
    end,
    group = toggle_pane_group,
    pattern = '*',
})
