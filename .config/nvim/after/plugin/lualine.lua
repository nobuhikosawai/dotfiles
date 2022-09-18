if not pcall(require, "lualine") then
	return
end

require("lualine").setup{
  options = {
    globalstatus = true,
  },
}
