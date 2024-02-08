return {
    'nvim-telescope/telescope.nvim',
    name = 'telescope',
    branch = '0.1.x',
    dependencies = {
        'plenary',
        -- Fuzzy Finder Algorithm which requires local dependencies to be built.
        -- Only load if `make` is available. Make sure you have the system
        -- requirements installed.
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            -- NOTE: If you are having trouble with this installation,
            --       refer to the README for telescope-fzf-native for more instructions.
            build = 'make',
            cond = function()
                return vim.fn.executable 'make' == 1
            end,
        },
        { 'nvim-telescope/telescope-ui-select.nvim' },
        { 'folke/trouble.nvim' },
    },
    config = function(_, opts)
        local t = require 'telescope'
        local trouble = require 'trouble.providers.telescope'
        opts = vim.tbl_deep_extend('force', {
            defaults = {
                mappings = {
                    i = { ['<C-t>'] = trouble.open_with_trouble },
                    n = { ['<C-t>'] = trouble.open_with_trouble },
                },
            },
        }, opts)
        opts.extensions = vim.tbl_extend('force', vim.F.if_nil(opts.extensions, {}), {
            ['ui-select'] = {
                require('telescope.themes').get_dropdown {},
            },
        })
        t.setup(opts)
        pcall(t.load_extension, 'fzf')
        pcall(t.load_extension, 'ui-select')
    end,
    opts = {
        defaults = {
            mappings = {
                i = {
                    ['<C-u>'] = false,
                    ['<C-d>'] = false,
                },
            },
        },
        pickers = {
            find_files = {
                theme = 'dropdown',
                layout_config = {
                    width = 0.8,
                    height = 0.3,
                },
                find_command = { 'rg', '--hidden', '--files' },
                prompt_prefix = ' 󰱼 ',
            },
            oldfiles = {
                theme = 'dropdown',
                layout_config = {
                    width = 0.8,
                    height = 0.3,
                },
            },
        },
    },
    -- stylua: ignore
    keys = {
        { '<leader>ff', function() require('telescope.builtin').find_files() end,                 desc = '[F]iles' },
        {
            '<leader>faf',
            function()
                require('telescope.builtin').find_files({
                    find_command = { 'rg', '--no-ignore', '--hidden', '--files' }
                })
            end,
            desc = '[a]ll [F]iles'
        },
        { '<leader>fh', function() require('telescope.builtin').help_tags() end,                  desc = '[H]elp' },
        { '<leader>fw', function() require('telescope.builtin').grep_string() end,                desc = 'current [W]ord' },
        { '<leader>g',  function() require('telescope.builtin').live_grep() end,                  desc = '[G]rep' },
        { '<leader>fd', function() require('telescope.builtin').diagnostics() end,                desc = '[D]iagnostics' },
        { '<leader>fr', function() require('telescope.builtin').resume() end,                     desc = '[R]esume' },
        { '<leader>of', function() require('telescope.builtin').oldfiles() end,                   desc = '[o]ld[f]iles' },
        { '<leader>fb', function() require('telescope.builtin').buffers() end,                    desc = 'existing [b]uffers' },
        { '<leader>gl', function() require('malteesch.plugins.telescope.pickers').gitlab() end,   desc = 'Open in [G]it[L]ab' },
        { '<leader>fp', function() require('malteesch.plugins.telescope.pickers').projects() end, desc = '[P]rojects' },
        { '<leader>fk', function() require('telescope.builtin').keymaps() end,                    desc = '[K]eymaps' },
        {
            '<leader>/',
            function()
                -- You can pass additional configuration to telescope to change theme, layout, etc.
                require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                    winblend = 10,
                    previewer = false,
                })
            end,
            desc = '[/] Fuzzily search in current buffer',
        },
    },
}
