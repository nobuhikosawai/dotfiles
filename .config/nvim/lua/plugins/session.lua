return {
  -- Session
  {
    "rmagatti/auto-session",
    event = "VeryLazy",

    opts = {
      log_level = "error",
      auto_session_suppress_dirs = { "~/", "/" },
      auto_save_enabled = true,
    },
  },
}
