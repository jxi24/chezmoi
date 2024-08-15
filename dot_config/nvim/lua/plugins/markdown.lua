return {
    {
        "OXY2DEV/markview.nvim",
        lazy = false,
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            modes = { "n", "i", "c" },
            hybrid_modes = { "i" },
        },
    }
}
