local pickers = require 'telescope.pickers'
local finders = require 'telescope.finders'
local conf = require('telescope.config').values
local actions = require 'telescope.actions'
local action_state = require 'telescope.actions.state'
local Job = require 'plenary.job'

local M = {}

M.gitlab = function(opts)
    opts = require('telescope.themes').get_dropdown(opts)
    pickers
        .new(opts, {
            prompt_title = 'Open in browser',
            finder = finders.new_table {
                results = {
                    { 'Repository', '' },
                    { ' Pipelines', '/-/pipelines' },
                    { ' Merge requests', '/-/merge_requests' },
                    { ' CI/CD settings', '/-/settings/ci_cd' },
                },
                entry_maker = function(entry)
                    return {
                        value = entry[2],
                        ordinal = entry[1],
                        display = entry[1],
                    }
                end,
            },
            sorter = conf.generic_sorter(opts),
            attach_mappings = function(prompt_bufnr)
                actions.select_default:replace(function()
                    actions.close(prompt_bufnr)
                    local selection = action_state.get_selected_entry()
                    Job:new({
                        command = 'git',
                        args = { 'remote', 'get-url', 'origin' },
                        cwd = vim.fn.getcwd(),
                        on_exit = function(job, code)
                            if code ~= 0 then
                                vim.notify(job:stderr_result()[1], vim.log.levels.ERROR, { title = 'Error opening remote' })
                            else
                                local remoteUrl = job:result()[1]:gsub(':', '/'):gsub('git@', 'https://'):gsub('%.git', ''):gsub('https///', 'https://')
                                if remoteUrl:find('gitlab', 1, true) == nil and selection.value ~= '' then
                                    vim.notify('Only GitLab remotes are supported', vim.log.levels.WARN, { title = 'Error opening remote' })
                                else
                                    Job:new({
                                        command = 'xdg-open',
                                        args = { remoteUrl .. selection.value },
                                    }):start()
                                end
                            end
                        end,
                    }):sync()
                end)
                return true
            end,
        })
        :find()
end

return M
