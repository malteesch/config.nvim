local function working_directory()
    return vim.fs.dirname(vim.fn.getcwd() or '') .. '/'
end

local function project_name()
    return vim.fs.basename(vim.fn.getcwd() or '')
end

local function relative_file_path()
    local dir = vim.fn.expand '%:h'
    if dir == '' then
        return ''
    elseif dir == '.' then
        return '/'
    else
        return '/' .. dir .. '/'
    end

end

local function filename()
    return vim.fn.expand '%:t'
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
                    { working_directory, color = 'Comment', padding = { right = 0, left = 1 } },
                    { project_name, padding = { left = 0, right = 0 }, color = 'lualine_a_inactive' },
                    { relative_file_path, padding = { left = 0 }, color = 'Comment' },
                    { filename, padding = { left = 0 }, color = 'lualine_a_inactive' },
                },
            },
        }
    end,
}
