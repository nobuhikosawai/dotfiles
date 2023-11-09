return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    cmd = { "Mason" },
    dependencies = {
      { "williamboman/mason.nvim", config = true },
      {
        "williamboman/mason-lspconfig.nvim",
        opts = {
          ensure_installed = {
            "lua_ls",
            "rust_analyzer",
            "tsserver",
            "tailwindcss",
            "graphql",
            "astro",
            "prismals",
            "mdx_analyzer",
            "eslint",
            "pyright",
          },
        },
      },
      {
        "j-hui/fidget.nvim",
        tag = "legacy",
        config = true,
        opts = {
          window = {
            blend = 0,
          },
        },
      },
      ----  Language specific plugins
      { "pmizio/typescript-tools.nvim", dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" } },
    },
    config = function()
      local nvim_lsp = require("lspconfig")
      -- Mappings.
      -- See `:help vim.diagnostic.*` for documentation on any of the below functions
      local opts = { noremap = true, silent = true }
      vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
      vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

      -- Use an on_attach function to only map the following keys
      -- after the language server attaches to the current buffer
      local on_attach = function(client, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

        -- Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
        -- vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
        -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
        -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
        -- vim.keymap.set('n', '<space>wl', function()
        --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        -- end, bufopts)
        -- vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
        vim.keymap.set("n", ",lr", vim.lsp.buf.rename, bufopts) -- suggested keymap is <leader>rn
        -- vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
        vim.keymap.set("n", ",gr", vim.lsp.buf.references, bufopts)
        vim.keymap.set("n", ",lf", function()
          vim.lsp.buf.format({ async = true })
        end, bufopts) -- suggested keymap is <leader>f
      end

      local lsp_flags = {
        -- This is the default in Nvim 0.7+
        debounce_text_changes = 150,
      }

      -- for nvim-ufo
      -- https://github.com/kevinhwang91/nvim-ufo
      local _capabilities = vim.lsp.protocol.make_client_capabilities()
      _capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }

      local capabilities = require("cmp_nvim_lsp").default_capabilities(_capabilities)

      -- lua_ls
      nvim_lsp.lua_ls.setup({
        on_attach = on_attach,
        flags = lsp_flags,
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = {
              -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
              version = "LuaJIT",
            },
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = { "vim" },
            },
            workspace = {
              -- Make the server aware of Neovim runtime files
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
              enable = false,
            },
          },
        },
      })

      -- typescript
      -- typescript-tools.nvim is used. if not, then use the following setup.
      -- nvim_lsp.tsserver.setup {
      --   on_attach = on_attach,
      --   filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
      --   cmd = { "typescript-language-server", "--stdio" },
      --   flags = lsp_flags,
      --   capabilities = capabilities,
      -- }
      require("typescript-tools").setup({})
      vim.api.nvim_set_keymap("n", "<leader>tr", ":TSToolsRemoveUnused<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>ta", ":TSToolsAddMissingImports<CR>", { noremap = true, silent = true })

      -- tailwindcss
      nvim_lsp.tailwindcss.setup({
        on_attach = on_attach,
        flags = lsp_flags,
        capabilities = capabilities,
      })

      -- graphql
      nvim_lsp.graphql.setup({
        on_attach = on_attach,
        flags = lsp_flags,
        capabilities = capabilities,
      })

      -- prisma
      nvim_lsp.prismals.setup({
        on_attach = on_attach,
        flags = lsp_flags,
        capabilities = capabilities,
      })

      -- astro
      nvim_lsp.astro.setup({
        on_attach = on_attach,
        flags = lsp_flags,
        capabilities = capabilities,
      })

      -- vue
      nvim_lsp.volar.setup({})

      -- eslint
      nvim_lsp.eslint.setup({})

      -- rust
      nvim_lsp.rust_analyzer.setup({
        on_attach = on_attach,
        flags = lsp_flags,
        -- Server-specific settings...
        settings = {
          ["rust-analyzer"] = {},
        },
        capabilities = capabilities,
      })

      -- mdx
      nvim_lsp.mdx_analyzer.setup({})

      -- ruby
      nvim_lsp.solargraph.setup({})
      --
      -- https://github.com/Shopify/ruby-lsp/blob/main/EDITORS.md
      -- textDocument/diagnostic support until 0.10.0 is released
      -- _timers = {}
      -- local function setup_diagnostics(client, buffer)
      --   if require("vim.lsp.diagnostic")._enable then
      --     return
      --   end
      --
      --   local diagnostic_handler = function()
      --     local params = vim.lsp.util.make_text_document_params(buffer)
      --     client.request("textDocument/diagnostic", { textDocument = params }, function(err, result)
      --       if err then
      --         local err_msg = string.format("diagnostics error - %s", vim.inspect(err))
      --         vim.lsp.log.error(err_msg)
      --       end
      --       local diagnostic_items = {}
      --       if result then
      --         diagnostic_items = result.items
      --       end
      --       vim.lsp.diagnostic.on_publish_diagnostics(
      --         nil,
      --         vim.tbl_extend("keep", params, { diagnostics = diagnostic_items }),
      --         { client_id = client.id }
      --       )
      --     end)
      --   end
      --
      --   diagnostic_handler() -- to request diagnostics on buffer when first attaching
      --
      --   vim.api.nvim_buf_attach(buffer, false, {
      --     on_lines = function()
      --       if _timers[buffer] then
      --         vim.fn.timer_stop(_timers[buffer])
      --       end
      --       _timers[buffer] = vim.fn.timer_start(200, diagnostic_handler)
      --     end,
      --     on_detach = function()
      --       if _timers[buffer] then
      --         vim.fn.timer_stop(_timers[buffer])
      --       end
      --     end,
      --   })
      -- end
      --
      -- nvim_lsp.ruby_ls.setup({
      --   on_attach = function(client, buffer)
      --     setup_diagnostics(client, buffer)
      --   end,
      -- })

      -- python
      nvim_lsp.pyright.setup({})
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "onsails/lspkind-nvim",
      {
        "zbirenbaum/copilot-cmp",
        dependencies = "zbirenbaum/copilot.lua",
        config = function()
          require("copilot_cmp").setup()
        end,
      }, -- copilot
      "f3fora/cmp-spell",
    },
    event = "InsertEnter",
    config = function()
      local cmp = require("cmp")
      local lspkind = require("lspkind")
      local luasnip = require("luasnip")

      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        window = {
          -- completion = cmp.config.window.bordered(),
          -- documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          -- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "nvim_lsp_signature_help" },
          { name = "luasnip" },
          { name = "copilot" },
          { name = "buffer" },
          {
            name = "spell",
            option = {
              keep_all_entries = false,
              enable_in_context = function()
                return true
              end,
            },
          },
        }),
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",
            menu = {
              buffer = "[Buffer]",
              nvim_lsp = "[LSP]",
              luasnip = "[LuaSnip]",
              nvim_lua = "[Lua]",
              latex_symbols = "[Latex]",
              Copilot = "",
            },
          }),
        },
        experimental = {
          ghost_text = {
            hl_group = "LspCodeLens",
          },
        },
      })

      -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
      -- cmp.setup.cmdline('/', {
      --   mapping = cmp.mapping.preset.cmdline(),
      --   sources = {
      --     { name = 'buffer' }
      --   }
      -- })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })
    end,
  },

  ----  Language specific plugins
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
    config = function()
      vim.api.nvim_set_keymap("n", "<leader>tr", ":TSToolsRemoveUnusedImports<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>ta", ":TSToolsAddMissingImports<CR>", { noremap = true, silent = true })
    end,
  },

  -- Additional LSP related plugins
  {
    "glepnir/lspsaga.nvim",
    branch = "main",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      { ",ca", "<cmd>Lspsaga code_action<CR>", desc = "code action", mode = { "n", "v" } },
    },
    opts = {
      symbol_in_winbar = {
        respect_root = true,
      },
    },
  },

  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>xx", "<cmd>TroubleToggle<cr>", desc = "TroubleToggle" },
      { "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "TroubleToggle workspace_diagnostics" },
      { "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "TroubleToggle document_diagnostics" },
      { "<leader>xl", "<cmd>TroubleToggle loclist<cr>", desc = "TroubleToggle loclist" },
      { "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", desc = "TroubleToggle quickfix" },
    },
    config = true,
  },

  {
    "stevearc/aerial.nvim",
    keys = {
      { "<leader>aa", "<cmd>AerialToggle!<CR>", desc = "AerialToggle" },
    },
    config = function()
      require("aerial").setup({
        on_attach = function(bufnr)
          vim.api.nvim_buf_set_keymap(bufnr, "n", "[[", "<cmd>AerialPrev<CR>", {})
          vim.api.nvim_buf_set_keymap(bufnr, "n", "]]", "<cmd>AerialNext<CR>", {})
        end,
      })
    end,
  },
  {
    "simrat39/symbols-outline.nvim",
    cmd = { "SymbolsOutline", "SymbolsOutlineOpen" },
    config = true,
  },

  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    config = function(_, opts)
      require("illuminate").configure(opts)
    end,
  },

  -- better folding
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    event = "BufReadPost",
    init = function()
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
      vim.keymap.set("n", "zR", function()
        require("ufo").openAllFolds()
      end)
      vim.keymap.set("n", "zM", function()
        require("ufo").closeAllFolds()
      end)
    end,
    config = true,
  },
}
