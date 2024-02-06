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

local wezterm_group = vim.api.nvim_create_augroup('Wezterm', { clear = true })
vim.api.nvim_create_autocmd('DirChanged', {
    callback = function()
        -- TODO implement syncing toggle pane dir
    end,
    group = wezterm_group,
    pattern = '*',
})
