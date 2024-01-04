local function working_directory()
    return vim.fs.dirname(vim.fn.getcwd()) .. '/'
end

local function project_name()
    return vim.fs.basename(vim.fn.getcwd())
end

return {
    'nvim-lualine/lualine.nvim',
    config = function()
        local catppuccin = require 'lualine.themes.catppuccin-mocha'
        catppuccin.normal.c.bg = '#1E1E2E'

        require('lualine').setup {
            options = {
                theme = catppuccin,
                icons_enabled = true,
                component_separators = '|',
                section_separators = '',
            },
            sections = {
                lualine_c = {
                    'filename',
                    { working_directory, color = 'Comment', padding = { right = 0 } },
                    { project_name, padding = { left = 0 } }
                },
            },
        }
    end,
}
