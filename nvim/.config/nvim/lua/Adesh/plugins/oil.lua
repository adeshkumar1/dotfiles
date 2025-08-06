return {
   "stevearc/oil.nvim",
   dependencies = { "nvim-tree/nvim-web-devicons" },
   config = function()
      require("oil").setup({
         default_file_explorer = true,
         columns = {},
         skip_confirm_for_simple_edits = true,
         view_options = {
            show_hidden = true,
         },
         keymaps = {
            ["<C-h>"] = false,
         },
         delete_to_trash = true,
      })

    vim.keymap.set("n", "<C-n>", require("oil").toggle_float)

    vim.api.nvim_create_autocmd("FileType", {
        pattern = "oil",
        callback = function()
            vim.opt_local.cursorline = true
        end
    })

   end,
}
