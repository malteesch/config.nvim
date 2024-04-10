--- @type LazyPluginSpec
return {
    'christoomey/vim-tmux-navigator',
    cmd = {
        'TmuxNavigateLeft',
        'TmuxNavigateDown',
        'TmuxNavigateUp',
        'TmuxNavigateRight',
        'TmuxNavigatePrevious',
    },
    keys = {
        { '<A-h>', '<CMD>TmuxNavigateLeft<CR>' },
        { '<A-j>', '<CMD>TmuxNavigateDown<CR>' },
        { '<A-k>', '<CMD>TmuxNavigateUp<CR>' },
        { '<A-l>', '<CMD>TmuxNavigateRight<CR>' },
    },
    init = function()
        vim.g.tmux_navigator_no_mappings = 1
        vim.g.tmux_navigator_disable_when_zoomed = 1
    end,
}
