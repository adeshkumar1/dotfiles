return {
  "rmagatti/auto-session",
  lazy = false,
  opts = {
    auto_save = true,
    auto_restore = true,
    auto_create = true,
    post_restore_cmds = {
      function()
        -- Trigger BufRead events on all restored buffers so lazy-loaded plugins
        -- (treesitter, etc.) activate and syntax highlighting works
        vim.cmd("doautoall BufReadPost")
      end,
    },
  },
}
