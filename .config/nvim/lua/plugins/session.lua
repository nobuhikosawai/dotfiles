return {
  -- Session
  {
    "rmagatti/auto-session",
    event = "VeryLazy",
    enabled = false,

    opts = {
      log_level = "error",
      auto_session_suppress_dirs = { "~/", "/" },
      auto_save_enabled = true,
    },
  },
}
