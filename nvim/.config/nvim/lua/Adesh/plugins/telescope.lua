return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {"nvim-telescope/telescope-fzf-native.nvim", build = "make"},
        "nvim-tree/nvim-web-devicons",
        "andrew-george/telescope-themes",
    },

    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        local builtin = require("telescope.builtin")

        telescope.load_extension("fzf")

        telescope.setup({
            defaults = {
                path_display = {"smart"},
                mappings = {
                    i = {
                        -- ["<C-p>"] = actions.move_selection_previous,
                        -- ["<C-n>"] = actions.move_selection_next,
                    },
                },
            }
        })

        
    end
}
