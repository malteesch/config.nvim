--- @type LazyPluginSpec
return {
    "shellRaining/hlchunk.nvim",
    event = { "UIEnter" },
    opts = {
        line_num = {
            enable = false
        }
    }
}
