--- @type LazyPluginSpec
return {
    'epwalsh/obsidian.nvim',
    version = '*', -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = 'markdown',
    event = {
      -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
      "BufReadPre " .. vim.fn.expand('~') .. "/Cerebro/**.md",
      "BufNewFile " .. vim.fn.expand('~') .. "/Cerebro/**.md",
    },
    dependencies = {
        -- Required.
        'plenary',
        'hrsh7th/nvim-cmp',
        'telescope',
        'nvim-treesitter/nvim-treesitter',
    },
    opts = {
        workspaces = {
            {
                name = 'cerebro',
                path = '~/Cerebro',
            },
        },
        follow_url_func = function (url)
            vim.fn.jobstart({"xdg-open", url})
        end
    },
    config = function (_, opts)
        require("obsidian").setup(opts)
        vim.o.conceallevel = 1
    end
}
