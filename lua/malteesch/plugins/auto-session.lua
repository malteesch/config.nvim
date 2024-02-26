--- @type LazyPluginSpec
return {
    'rmagatti/auto-session',
    opts = {
        log_level = 'error',
        auto_session_suppress_dirs = { '~/', '~/Downloads', '/' },
    },
    config = function(_, opts)
        require("auto-session").setup(opts)
        vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
    end,
    init = function()
        local auto_session_group = vim.api.nvim_create_augroup('AutoSession', { clear = true })
        vim.api.nvim_create_autocmd('DirChangedPre', {
            pattern = '*',
            callback = function()
                vim.cmd 'SessionSave'
            end,
            group = auto_session_group,
        })
        vim.api.nvim_create_autocmd('DirChanged', {
            pattern = '*',
            callback = function()
                vim.cmd 'SessionRestore'
            end,
            group = auto_session_group,
        })
    end,
}
