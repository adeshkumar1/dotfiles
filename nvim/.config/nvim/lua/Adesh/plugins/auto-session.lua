return {
  "rmagatti/auto-session",
  lazy = false,
  opts = {
    auto_save = true,
    auto_restore = true,
    auto_create = true,
    post_restore_cmds = {
      function()
        -- Re-trigger FileType on all loaded buffers so treesitter attaches and highlights
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].filetype ~= "" then
            vim.api.nvim_buf_call(buf, function()
              vim.cmd("filetype detect")
            end)
          end
        end
      end,
    },
  },
}
