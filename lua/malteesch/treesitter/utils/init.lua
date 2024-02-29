local M = {}

--- @param node TSNode
--- @param cursor integer[]
function M.cursor_is_in_range(node, cursor)
    local row = cursor[1] - 1
    local col = cursor[2]
    local start_row, start_col, end_row, end_col = node:range()
    -- P(string.format('row: start %s, end %s col: start %s, end %s cursor: row %s, col %s', start_row, end_row, start_col, end_col, row, col))
    if start_row < row and end_row > row then
        return true
    end
    if start_row == row and start_col <= col then
        return true
    end
    if end_row == row and end_col >= col then
        return true
    end
    return false
end

--- @param node TSNode
--- @return string
function M.get_node_text(node)
    local start_row, start_col, end_row, end_col = node:range()
    return vim.api.nvim_buf_get_text(0, start_row, start_col, end_row, end_col, {})[1]
end

return M
