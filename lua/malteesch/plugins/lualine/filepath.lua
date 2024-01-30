local string_utils = require("malteesch.util").string
local M = require('lualine.component'):extend()
local highlight = require 'lualine.highlight'
local catppuccin = require 'lualine.themes.catppuccin-mocha'

function M:init(options)
    M.super.init(self, options)
    self.colors = {
        text = highlight.create_component_highlight_group({ fg = '#6c7086' }, 'filepath_text', self.options),
        dir = highlight.create_component_highlight_group({ fg = catppuccin.normal.b.fg }, 'filepath_dir', self.options),
        file = highlight.create_component_highlight_group({ fg = catppuccin.normal.b.fg }, 'filepath_file', self.options),
    }
end

function M:update_status()
    local cwd = vim.fn.getcwd()
    local parent = vim.fs.dirname(cwd)
    local curr_file_abs = vim.fn.expand '%:p'
    if not string_utils.starts_with(curr_file_abs, cwd) then
        return string.format('%s%s', highlight.component_format_highlight(self.colors.text), curr_file_abs)

    end

    local parts = {
        string.format('%s%s', highlight.component_format_highlight(self.colors.text), vim.fn.fnamemodify(parent, ':p:h')),
        string.format('%s%s', highlight.component_format_highlight(self.colors.dir), vim.fs.basename(cwd)),
    }
    local curr_file_dir = vim.fn.expand '%:.:h'
    if curr_file_dir ~= '.' then
        table.insert(parts, string.format('%s%s', highlight.component_format_highlight(self.colors.text), curr_file_dir))
    end
    local curr_file_name = vim.fn.expand '%:.:t'
    if curr_file_name ~= '' then
        table.insert(parts, string.format('%s%s', highlight.component_format_highlight(self.colors.file), curr_file_name))
    end
    return table.concat(parts, string.format('%s%s', highlight.component_format_highlight(self.colors.text), '/'))
end

return M
