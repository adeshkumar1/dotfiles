return {
   "stevearc/oil.nvim",
   dependencies = { "nvim-tree/nvim-web-devicons" },
   config = function()
      require("oil").setup({
         default_file_explorer = true,
         columns = {
            "icon",
         },
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

    function _G.oil_winbar()
        local ok, oil = pcall(require, "oil")
        if not ok then
            return ""
        end
        local dir = oil.get_current_dir()
        if not dir then
            return ""
        end
        return vim.fn.pathshorten(vim.fn.fnamemodify(dir, ":~"))
    end

    vim.api.nvim_create_autocmd("FileType", {
        pattern = "oil",
        callback = function()
            vim.opt_local.cursorline = true
            vim.opt_local.winbar = "%!v:lua.oil_winbar()"
        end
    })

   end,
}
