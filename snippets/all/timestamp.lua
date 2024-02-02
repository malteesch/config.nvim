local ls = require 'luasnip'
local s = ls.snippet
local f = ls.function_node

return {
    s('timestamp', {
        f(function()
            return string.format('%s', os.time(os.date('!*t')))
        end, {}, {}),
    }),
}
