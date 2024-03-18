--- @type LazyPluginSpec
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
            close = '<C-c>'
        },
        include_declaration = {},
        auto_jump = { 'lsp_definitions', 'lsp_implementations', 'lsp_references' },
    },
    config = function (_, opts)
        local trouble = require("trouble")
        trouble.setup(opts)
        vim.keymap.set('n', '<leader>to', trouble.open)
        vim.keymap.set('n', '<leader>tw', function () trouble.open("workspace_diagnostics") end)
        vim.keymap.set('n', '<leader>td', function () trouble.open("document_diagnostics") end)
    end,
}
