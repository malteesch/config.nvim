local ts_utils = require 'malteesch.treesitter.utils'

local M = {}

function M.run_junit_test_in_toggle_pane()
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
                local tab_id = vim.fn.system("kitten @ ls | jq '.[].tabs | map(select(.is_active == true)) | first | .id'"):gsub('\n', '')
                local gradle_module_path = ''
                local nearest_gradle_build_script = vim.fs.find({ 'build.gradle', 'build.gradle.kts' }, {
                    upward = true,
                    stop = vim.fs.dirname(vim.fn.getcwd()),
                    path = vim.fs.dirname(vim.api.nvim_buf_get_name(0)),
                })[1]
                local _, e = string.find(nearest_gradle_build_script, vim.fn.getcwd(), 1, true)
                gradle_module_path = vim.fs.dirname(nearest_gradle_build_script):sub(e + 1):gsub('/', ':')

                vim.fn.system("kitten @ --to $KITTY_LISTEN_ON action kitten toggle_pane.py")
                vim.fn.system(
                    string.format(
                        "kitten @ --to $KITTY_LISTEN_ON send-text --match='title:^toggle-%s$' '%s'",
                        tab_id,
                        string.format("./gradlew %s:test --tests='%s.%s' --info\n", gradle_module_path, class_name, method_name)
                    )
                )
            end
        end
    end
end

return M
