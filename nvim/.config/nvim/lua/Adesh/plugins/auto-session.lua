return {
  "rmagatti/auto-session",
  lazy = false,
  opts = {
    auto_save = true,
    auto_restore = true,
    auto_create = true,
    post_restore_cmds = {
      "colorscheme rose-pine",
      "doautoall BufRead",
    },
  },
}
