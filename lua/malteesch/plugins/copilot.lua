--- @type LazyPluginSpec
return {
    'github/copilot.vim',
    config = function ()
        vim.g.copilot_enabled = 0
        vim.keymap.set('i', '<C-Tab>', 'copilot#Accept("\\<CR>")', {
          expr = true,
          replace_keycodes = false
        })
        vim.g.copilot_no_tab_map = true
    end,
}
