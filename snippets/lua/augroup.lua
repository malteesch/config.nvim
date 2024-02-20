local ls = require 'luasnip'
local s = ls.snippet
local i = ls.insert_node
local fmta = require('luasnip.extras.fmt').fmta

return {
    s(
        { trig = 'augroup', name = 'Create augroup' },
        fmta([[local <group_var_name> = vim.api.nvim_create_augroup("<group_name>", { clear = true })]], {
            group_var_name = i(1),
            group_name = i(2),
        })
    ),
}
