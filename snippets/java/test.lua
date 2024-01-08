local ls = require 'luasnip'
local s = ls.snippet
local i = ls.insert_node
local fmt = require('luasnip.extras.fmt').fmt

return {
    s(
        { trig = 'test', name = 'test method' },
        fmt(
            [[@Test
void {1}() {{
    {2}
}}]],
            { i(1, 'test'), i(2) }
        ),
        {
            show_condition = function()
                local query = vim.treesitter.query.parse('java', '(class_declaration name: (identifier))')
                local root = vim.treesitter.get_node():tree():root()
                local last_line = vim.fn.line('$')

                for _, node, _ in query:iter_captures(root, 0, 1, last_line) do
                    local start_row, start_col, end_row, end_col = node:range()
                    local class_name = vim.api.nvim_buf_get_text(0, start_row, start_col, end_row, end_col, {})[1]
                    return class_name:match 'Test'
                end

                return false
            end,
        }
    ),
}
