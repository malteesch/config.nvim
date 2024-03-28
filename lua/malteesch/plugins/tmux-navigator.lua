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
}
