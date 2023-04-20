return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
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
            "marksman",
          },
        },
      },
      { "j-hui/fidget.nvim", config = true },
      ----  Language specific plugins
      "jose-elias-alvarez/typescript.nvim",
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
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
        -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
        -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
        -- vim.keymap.set('n', '<space>wl', function()
        --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        -- end, bufopts)
        -- vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
        vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, bufopts) -- suggested keymap is <leader>rn
        -- vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
        vim.keymap.set("n", "<space>lf", function()
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
      -- typescript.nvim(https://github.com/jose-elias-alvarez/typescript.nvim) is used. if not, then use the following setup.
      -- nvim_lsp.tsserver.setup {
      --   on_attach = on_attach,
      --   filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
      --   cmd = { "typescript-language-server", "--stdio" },
      --   flags = lsp_flags,
      --   capabilities = capabilities,
      -- }
      require("typescript").setup({
        disable_commands = false, -- prevent the plugin from creating Vim commands
        debug = false, -- enable debug logging for commands
        go_to_source_definition = {
          fallback = true, -- fall back to standard LSP definition on failure
        },
        server = {
          -- pass options to lspconfig's setup method
          on_attach = on_attach,
          filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
          cmd = { "typescript-language-server", "--stdio" },
          flags = lsp_flags,
          capabilities = capabilities,
        },
      })

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
      nvim_lsp.volar.setup{}

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

      -- marksman(markdown)
      nvim_lsp.marksman.setup({})

      -- ruby
      nvim_lsp.solargraph.setup({})
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

  -- Additional LSP related plugins
  {
    "glepnir/lspsaga.nvim",
    branch = "main",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      { "<leader>ca", "<cmd>Lspsaga code_action<CR>", desc = "code action", mode = { "n", "v" } },
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