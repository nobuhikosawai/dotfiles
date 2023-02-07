if (not pcall(require, 'auto-session')) then
  return
end


require("auto-session").setup {
  log_level = "error",
  auto_session_suppress_dirs = { "~/", "/"},
  auto_save_enabled = true
}
