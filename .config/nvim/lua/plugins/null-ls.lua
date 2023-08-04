return {
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      local null_ls = require("null-ls")
      local h = require("null-ls.helpers")
      local u = require("null-ls.utils")

      null_ls.setup({
        sources = {
          null_ls.builtins.diagnostics.eslint_d.with({
            cwd = h.cache.by_bufnr(function(params)
              return u.root_pattern(
                ".eslintrc",
                ".eslintrc.js",
                ".eslintrc.cjs",
                ".eslintrc.yaml",
                ".eslintrc.yml",
                ".eslintrc.json"
              )(params.bufname)
            end),
          }),
          null_ls.builtins.diagnostics.cspell.with({
            extra_args = { "--config", "~/.config/cspell/cspell.json" },
            diagnostics_postprocess = function(diagnostic)
              diagnostic.severity = vim.diagnostic.severity.HINT
            end,
            diagnostic_config = {
              virtual_text = false,
            },
          }),
          null_ls.builtins.diagnostics.shellcheck,
          null_ls.builtins.formatting.prettierd,
          null_ls.builtins.formatting.stylua,
        },
        debug = false,
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ async = false })
              end,
            })
          end
        end,
      })
    end,
  },
}
