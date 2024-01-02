return {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    lazy = false,
    opts = {
        mode = 'document_diagnostics',
        use_diagnostic_signs = true,
        action_keys = {
            jump = { '<TAB>' },
            jump_close = { '<CR>' },
        },
        include_declaration = {},
        auto_jump = { 'lsp_definitions', 'lsp_implementations', 'lsp_references' },
    },
    keys = {
        {
            '<leader>xx',
            function()
                require('trouble').toggle()
            end,
        },
    },
}
