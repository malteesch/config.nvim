local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require('luasnip.extras.fmt').fmt

return {
    s({ trig = 'type', name = 'Type annotation' }, { t '--- @type ', i(1) }),
    s({ trig = 'lps', name = 'LazyPluginSpec type annotation' }, { t '--- @type LazyPluginSpec' }),

    s({ trig = 'sib', name = 'Stylua ignore block' }, fmt([[-- stylua: ignore start]] .. '\n' .. [[{1}]] .. '\n' .. [[-- stylua: ignore end]], { i(1) })),
}
