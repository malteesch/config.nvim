local ts_utils = require 'malteesch.treesitter.utils'

local M = {}

function M.run_junit_test_in_wezterm()
    vim.cmd.w()
    local parser = require('nvim-treesitter.parsers').get_parser()
    local query = vim.treesitter.query.parse(
        parser:lang(),
        [[(class_declaration
              name: (identifier) @class_name
              body: (class_body
                      (method_declaration
                        (modifiers
                          (marker_annotation
                            name: (identifier) @annotation_name))
                        name: (identifier) @method_name) @method))
        ]]
    )

    local root = parser:parse()[1]:root()
    local last_line = vim.fn.line '$' or 0

    for _, match, _ in query:iter_matches(root, 0, 1, last_line) do
        local captures = {}
        for id, node in pairs(match) do
            -- local start_row, start_col, end_row, end_col = node:range()
            captures[query.captures[id]] = node --vim.api.nvim_buf_get_text(0, start_row, start_col, end_row, end_col, {})[1]
        end
        local cursor = vim.api.nvim_win_get_cursor(0)
        if ts_utils.cursor_is_in_range(captures['method'], cursor) then
            local annotation_name = ts_utils.get_node_text(captures['annotation_name'])
            if annotation_name == 'Test' or annotation_name == 'ParameterizedTest' then
                local class_name = ts_utils.get_node_text(captures['class_name'])
                local method_name = ts_utils.get_node_text(captures['method_name'])
                local wt = require 'wezterm'
                local pane_id = wt.get_current_pane()
                if pane_id == nil then
                    return
                end
                local gradle_module_path = ''
                local nearest_gradle_build_script = vim.fs.find({ 'build.gradle', 'build.gradle.kts' }, {
                    upward = true,
                    stop = vim.fs.dirname(vim.fn.getcwd()),
                    path = vim.fs.dirname(vim.api.nvim_buf_get_name(0)),
                })[1]
                local _, e = string.find(nearest_gradle_build_script, vim.fn.getcwd(), 1, true)
                gradle_module_path = vim.fs.dirname(nearest_gradle_build_script):sub(e + 1):gsub('/', ':')

                wt.exec({ 'cli', 'zoom-pane', '--unzoom', '--pane-id', string.format('%d', pane_id) }, function() end)
                wt.exec({ 'cli', 'activate-pane', '--pane-id', string.format('%d', pane_id + 1) }, function() end)
                wt.exec({
                    'cli',
                    'send-text',
                    '--no-paste',
                    '--pane-id',
                    string.format('%d', pane_id + 1),
                    string.format("./gradlew %s:test --tests='%s.%s' --info\n", gradle_module_path, class_name, method_name),
                }, function() end)
            end
        end
    end
end

return M
