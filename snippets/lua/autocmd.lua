local ls = require 'luasnip'
local s = ls.snippet
local i = ls.insert_node
local fmta = require('luasnip.extras.fmt').fmta

return {
    s(
        { trig = 'autocmd', name = 'Create autocmd' },
        fmta(
            [[vim.api.nvim_create_autocmd("<event>", {
    pattern = '<pattern>',
    callback = function() end,
    group = <group>
})]],
            { event = i(1), group = i(2, 'augroup'), pattern = i(3, '*') }
        )
    ),
}
