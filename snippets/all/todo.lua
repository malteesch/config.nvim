local calculate_comment_string = require('Comment.ft').calculate
local utils = require 'Comment.utils'
local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node

local function get_comment_string()
    local cs = calculate_comment_string { ctype = 1, range = utils.get_region() } or vim.bo.commentstring
    return utils.unwrap_cstr(cs)
end

return {
    s('todo', {
        f(function()
            return get_comment_string()
        end, {}, {}),
        t ' ',
        c(1, { t 'TODO', t 'FIX' }),
        t ' ',
        i(2),
    }),
}
