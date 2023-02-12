return {
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local async_formatting = function(bufnr)
        bufnr = bufnr or vim.api.nvim_get_current_buf()

        vim.lsp.buf_request(
          bufnr,
          "textDocument/formatting",
          vim.lsp.util.make_formatting_params({}),
          function(err, res, ctx)
            if err then
              local err_msg = type(err) == "string" and err or err.message
              -- you can modify the log message / level (or ignore it completely)
              vim.notify("formatting: " .. err_msg, vim.log.levels.WARN)
              return
            end

            -- don't apply results if buffer is unloaded or has been modified
            if not vim.api.nvim_buf_is_loaded(bufnr) or vim.api.nvim_buf_get_option(bufnr, "modified") then
              return
            end

            if res then
              local client = vim.lsp.get_client_by_id(ctx.client_id)
              vim.lsp.util.apply_text_edits(res, bufnr, client and client.offset_encoding or "utf-16")
              vim.api.nvim_buf_call(bufnr, function()
                vim.cmd("silent noautocmd update")
              end)
            end
          end
        )
      end

      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      local null_ls = require("null-ls")

      null_ls.setup({
        sources = {
          null_ls.builtins.diagnostics.eslint_d.with({
            condition = function(utils)
              return utils.root_has_file({
                ".eslintrc.js",
                ".eslintrc.cjs",
                ".eslintrc.json",
                "eslint.config.js",
              })
            end,
            prefer_local = "node_modules/.bin",
          }),
          null_ls.builtins.diagnostics.cspell.with({
            extra_args = { "--config", "~/.config/cspell/cspell.json" },
          }),
          null_ls.builtins.diagnostics.shellcheck,
          null_ls.builtins.formatting.prettierd,
          null_ls.builtins.formatting.stylua,
        },
        debug = false,
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePost", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                async_formatting(bufnr)
              end,
            })
          end
        end,
      })
    end,
  },
}
