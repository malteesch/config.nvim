return {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function(_, opts)
        require('catppuccin').setup(opts)
        vim.cmd.colorscheme 'catppuccin'
    end,
    opts = {
        flavour = 'mocha',
        term_colors = true,
        integrations = {
            neotree = true,
            gitsigns = true,
            telescope = {
                enabled = true,
            },
            which_key = true,
            mason = true,
            leap = true,
            harpoon = true,
            noice = true,
            cmp = true,
            fidget = true,
            notify = true,
            treesitter = true,
            lsp_trouble = true,
        },
        custom_highlights = function(colors)
            return {
                CursorLineNr = { fg = colors.teal },
                LineNr = { fg = colors.overlay2 },
            }
        end,
    },
}
