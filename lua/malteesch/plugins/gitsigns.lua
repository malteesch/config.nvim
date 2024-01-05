return {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    event = { 'BufEnter' },
    opts = {
        -- See `:help gitsigns.txt`
        signs = {
            add = { text = '|' },
            change = { text = '|' },
            delete = { text = '_' },
            topdelete = { text = '‾' },
            changedelete = { text = '|' },
        },
        on_attach = function(bufnr)
            vim.keymap.set('n', '<leader>ghp', require('gitsigns').preview_hunk, { buffer = bufnr, desc = '[h]unk [p]review' })
            vim.keymap.set('n', '<leader>gb', require('gitsigns').blame_line, { buffer = bufnr, desc = '[G]it [b]lame line' })
            vim.keymap.set('n', '<leader>tgd', require('gitsigns').toggle_word_diff, { buffer = bufnr, desc = '[g]it word [d]iff' })
            vim.keymap.set('n', '<leader>ghr', require('gitsigns').reset_hunk, { buffer = bufnr, desc = '[h]unk [r]eset' })
            vim.keymap.set('n', '<leader>ghp', require('gitsigns').preview_hunk, { buffer = bufnr, desc = '[h]unk [p]review' })
            vim.keymap.set('n', '<leader>gfr', function()
                local result = vim.fn.confirm('Reset all changes in this file?', '&Yes\n&No', 2, 'Warning')
                if result == 1 then
                    require('gitsigns').reset_buffer()
                end
            end, { buffer = bufnr, desc = '[f]ile [r]eset' })

            -- don't override the built-in and fugitive keymaps
            local gs = package.loaded.gitsigns
            vim.keymap.set({ 'n', 'v' }, ']c', function()
                if vim.wo.diff then
                    return ']c'
                end
                vim.schedule(function()
                    gs.next_hunk()
                end)
                return '<Ignore>'
            end, { expr = true, buffer = bufnr, desc = 'Jump to next hunk' })
            vim.keymap.set({ 'n', 'v' }, '[c', function()
                if vim.wo.diff then
                    return '[c'
                end
                vim.schedule(function()
                    gs.prev_hunk()
                end)
                return '<Ignore>'
            end, { expr = true, buffer = bufnr, desc = 'Jump to previous hunk' })
        end,
    },
}
