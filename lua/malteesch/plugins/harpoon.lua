return {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    opts = {
        settings = {},
    },
    config = function(_, opts)
        local harpoon = require 'harpoon'
        harpoon:setup(opts)

        vim.keymap.set('n', '<leader>ha', function()
            harpoon:list():append()
        end, { desc = '[a]ppend file' })
        vim.keymap.set('n', '<leader>hp', function()
            harpoon:list():prepend()
        end, { desc = '[p]repend file' })
        vim.keymap.set('n', '<leader>hr', function()
            harpoon:list():remove()
        end, { desc = '[r]emove file' })
        vim.keymap.set('n', '<leader>hc', function()
            harpoon:list():clear()
        end, { desc = '[c]lear list' })
        vim.keymap.set('n', '<leader>hl', function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end, { desc = '[l]ist popup' })

        vim.keymap.set('n', '<C-j>', function()
            harpoon:list():select(1)
        end, { desc = 'Jump to harpoon item 1' })
        vim.keymap.set('n', '<C-k>', function()
            harpoon:list():select(2)
        end, { desc = 'Jump to harpoon item 2' })
        vim.keymap.set('n', '<C-l>', function()
            harpoon:list():select(3)
        end, { desc = 'Jump to harpoon item 3' })
        vim.keymap.set('n', '<C-h>', function()
            harpoon:list():select(4)
        end, { desc = 'Jump to harpoon item 4' })
    end,
}
