return {
    {
        "epwalsh/obsidian.nvim",
        version = "*",
        lazy = false,
        ft = "markdown",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        opts = {
            workspaces = {
                {
                    name = "Personal",
                    path = "~/Documents/Obsidian/Personal/",
                },
                {
                    name = "Work",
                    path = "~/Documents/Obsidian/Work/",
                },
            },
            daily_notes = {
                date_format = "%Y-%m-%d",
                template = "~/Documents/Obsidian/Work/templates/daily"
            },
            completion = {
                nvim_cmp = true,
                min_chars = 2,
            },
            mappings = {
                ["gf"] = {
                    action = function()
                        return require("obsidian").util.gf_passthrough()
                    end,
                    opts = { noremap = false, expr = true, buffer = true },
                },
                ["<leader>oc"] = {
                    action = function()
                        return require("obsidian").util.toggle_checkbox()
                    end,
                    opts = { buffer = true },
                    desc = "Toggle checkbox",
                },
                ["<cr>"] = {
                    action = function()
                        return require("obsidian").util.smart_action()
                    end,
                    opts = { buffer = true, expr = true },
                }
            },
            follow_url_func = function(url)
                vim.fn.jobstart({"xdg-open", url})
            end,
            templates = {
                folder = "~/Documents/Obsidian/Work/templates",
                date_format = "%Y-%m-%d",
                time_format = "%H:%M",
                substitutions = {
                    name_date = function()
                        return os.date("%b %d, %Y", os.time())
                    end,
                }
            },
        },
        keys = {
            { "<leader>o", "", desc = "Obsidian" },
            { "<leader>ot", "<cmd>ObsidianToday<cr>", desc = "Today's note" },
            { "<leader>oy", "<cmd>ObsidianYesterday<cr>", desc = "Yesterday's note" },
            { "<leader>od", "<cmd>ObsidianDailies<cr>", desc = "Open daily note selector" },
        },
    }
}
