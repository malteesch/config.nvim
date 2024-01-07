local pickers = require 'telescope.pickers'
local finders = require 'telescope.finders'
local conf = require('telescope.config').values
local actions = require 'telescope.actions'
local action_state = require 'telescope.actions.state'
local entry_display = require 'telescope.pickers.entry_display'

local displayer = entry_display.create {
    separator = ' ',
    items = {
        {
            width = 30,
        },
        {
            remaining = true,
        },
    },
}

local DIR = vim.fn.expand '~'

local function make_display(entry)
    return displayer { entry.name, { entry.value, 'Comment' } }
end

local function make_value(line)
    local dir = line:gsub('%.git/', ''):gsub('/$', '')
    return dir
end

local function make_name(line)
    local split = vim.split(line, '/', { trimempty = true })
    return split[#split - 1]
end

local function make_absolute_path(line)
    return DIR .. '/' .. make_value(line)
end

local M = {}

M.projects = function(opts)
    opts = opts or {}
    pickers
        .new(opts, {
            prompt_title = 'Open project',
            finder = finders.new_oneshot_job({ 'fd', '--type', 'directory', '--hidden', '--no-ignore', '.git$', 'projects', '.config/nvim' }, {
                entry_maker = function(line)
                    return {
                        name = make_name(line),
                        value = make_value(line),
                        ordinal = line,
                        display = make_display,
                        path = make_absolute_path(line),
                    }
                end,
                cwd = DIR,
            }),
            sorter = conf.generic_sorter(opts),
            attach_mappings = function(prompt_bufnr)
                actions.select_default:replace(function()
                    actions.close(prompt_bufnr)
                    local selection = action_state.get_selected_entry()
                    vim.api.nvim_set_current_dir(selection.path)
                end)
                return true
            end,
        })
        :find()
end

return M
