return {
    {
        "neovim/nvim-lspconfig",
        lazy=false,
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "j-hui/fidget.nvim",
        },
        config = function()
            local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
            local capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                has_cmp and cmp_nvim_lsp.default_capabilities() or {})

            require('fidget').setup({})
            require('mason').setup()
            require('mason-lspconfig').setup({
                ensure_installed = {
                    'clangd',
                    'fortls',
                    'neocmake',
                    'lua_ls',
                    'rust_analyzer',
                },
                handlers = {
                    function(server_name)
                        require('lspconfig')[server_name].setup {
                            capabilities = capabilities
                        }
                    end,
                },
            })
            local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end
        end,
        keys = {
            { "<leader>li", "<cmd>LspInfo<cr>", desc = "Lsp Info" },
            { "<leader>ld", vim.lsp.buf.definition(), desc = "Goto Definition" },
            { "<leader>lr", vim.lsp.buf.references(), desc = "References" },
            { "<leader>lI", vim.lsp.buf.implementation(), desc = "Goto Implementation" },
            { "<leader>ly", vim.lsp.buf.type_definition(), desc = "Goto Type Definition" },
            { "<leader>lD", vim.lsp.buf.declaration(), desc = "Goto Declaration" },
            { "K", vim.lsp.buf.hover, desc = "Hover" },
            { "<leader>lK", vim.lsp.buf.hover, desc = "Hover" },
            { "<C-h>", vim.lsp.buf.signature_help, mode="i", desc = "Signature Help" },
            { "<leader>lR", vim.lsp.buf.rename, desc = "Rename" },
            { "<leader>lp", vim.diagnostic.goto_prev, desc = "Prev Diagnostic" },
            { "<leader>ln", vim.diagnostic.goto_next, desc = "Next Diagnostic" },
            { "<leader>le", vim.diagnostic.open_float, desc = "Show Error Messages" },
            { "<leader>lq", vim.lsp.buf.code_action, desc = "Code action", mode = { "n", "v" }},
        },
    },
    {
        "hrsh7th/nvim-cmp",
        version = false,
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
        },

        opts = function()
            local cmp = require("cmp")
            local cmp_select = { behavior = cmp.SelectBehavior.Select }

            return {
                completion = { completeopt = 'menu,menuone,noinsert' },
                preselect = cmp.PreselectMode.Item,
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
                    ['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
                    ['<C-l>'] = cmp.mapping.confirm({ select = true }),
                }),
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'path' },
                }, {
                    { name = 'buffer' },
                })
            }
        end
    },
}

