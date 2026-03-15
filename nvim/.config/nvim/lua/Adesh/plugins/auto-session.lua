return {
  "rmagatti/auto-session",
  lazy = false,
  opts = {
    auto_save = true,
    auto_restore = true,
    auto_create = true,
    post_restore_cmds = {
      function()
        -- Re-trigger BufReadPost so lazy-loaded plugins (treesitter, etc.) activate
        local bufnr = vim.api.nvim_get_current_buf()
        vim.api.nvim_exec_autocmds("BufReadPost", { buffer = bufnr })
      end,
    },
  },
}
