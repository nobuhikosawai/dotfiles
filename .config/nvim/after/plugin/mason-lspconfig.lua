if not pcall(require, "mason-lspconfig") then
	return
end

require("mason-lspconfig").setup({
    ensure_installed = { "sumneko_lua", "rust_analyzer", "tsserver" }
})
