return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
    opts = function()
        require('which-key').setup {
            win = {
                -- position = "bottom",        -- bottom, top
                -- margin = { 1, 0, 1, 500 }, -- extra window margin [top, right, bottom, left]. When between 0 and 1, will be treated as a percentage of the screen size.
                padding = { 1, 2, 1, 1000 },
             
                
            },
        }
        require('which-key').add {
            {"<leader>f", group = "Find"},
            -- ['<leader>'] = {
            --     f = {
            --         name = 'Find',
            --     },
            --     g = {
            --         name = 'Git',
            --     },
            --     t = {
            --         name = 'Terminal',
            --     },
            --     l = {
            --         name = 'Lsp',
            --     },
            --     b = {
            --         name = 'Buffer',
            --     }
            -- }
        }
    end
}