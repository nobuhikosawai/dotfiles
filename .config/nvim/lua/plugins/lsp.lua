return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    cmd = { "Mason" },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      {
        "mason-org/mason-lspconfig.nvim",
        opts = {
          ensure_installed = {
            "lua_ls",
            "rust_analyzer",
            "ts_ls",
            "tailwindcss",
            "graphql",
            "astro",
            "prismals",
            "mdx_analyzer",
            "eslint",
            "pyright",
            "texlab",
            "clangd",
          },
          -- Servers are enabled explicitly below.
          -- Avoid starting ts_ls alongside typescript-tools.
          automatic_enable = false,
        },
      },
      "hrsh7th/cmp-nvim-lsp",
      {
        "j-hui/fidget.nvim",
        opts = {
          notification = {
            window = {
              winblend = 0,
            },
          },
        },
      },
      {
        "pmizio/typescript-tools.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
      },
    },
    config = function()
      local opts = { silent = true }

      vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
      vim.keymap.set("n", "[d", function()
        vim.diagnostic.jump({ count = -1, float = true })
      end, opts)
      vim.keymap.set("n", "]d", function()
        vim.diagnostic.jump({ count = 1, float = true })
      end, opts)
      vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

      -- Common mappings for all attached LSP clients.
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {
          clear = true,
        }),
        callback = function(event)
          local bufnr = event.buf
          local bufopts = { silent = true, buffer = bufnr }

          vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

          -- Available actions: :help vim.lsp.buf
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
          vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
          vim.keymap.set("n", ",lr", vim.lsp.buf.rename, bufopts)
          vim.keymap.set("n", ",gr", vim.lsp.buf.references, bufopts)
          vim.keymap.set("n", ",lf", function()
            vim.lsp.buf.format({ bufnr = bufnr, async = true })
          end, bufopts)

          -- Optional mappings:
          -- vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
          -- vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
          -- vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
          -- vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
          -- vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
          -- vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
          -- vim.keymap.set("n", "<space>wl", function()
          --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          -- end, bufopts)
        end,
      })

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Folding support for nvim-ufo.
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }

      local lsp_flags = {
        debounce_text_changes = 150,
      }

      -- Shared defaults for servers enabled through vim.lsp.enable().
      vim.lsp.config("*", {
        capabilities = capabilities,
        flags = lsp_flags,
      })

      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })

      vim.lsp.config("rust_analyzer", {
        settings = {
          ["rust-analyzer"] = {},
        },
      })

      vim.lsp.config("clangd", {
        cmd = {
          "clangd",
          "--offset-encoding=utf-16",
        },
      })

      -- Native pull diagnostics replace the old Ruby polling workaround.
      vim.lsp.config("ruby_lsp", {
        on_attach = function(client, bufnr)
          vim.api.nvim_buf_create_user_command(bufnr, "ShowRubyDeps", function(command_opts)
            local params = {
              textDocument = {
                uri = vim.uri_from_bufnr(bufnr),
              },
            }

            client:request("rubyLsp/workspace/dependencies", params, function(err, result)
              if err then
                vim.notify("Error showing Ruby dependencies: " .. vim.inspect(err), vim.log.levels.ERROR)
                return
              end

              local items = {}
              for _, item in ipairs(result or {}) do
                if command_opts.args == "all" or item.dependency then
                  items[#items + 1] = {
                    text = string.format("%s (%s) - %s", item.name, item.version, tostring(item.dependency)),
                    filename = item.path,
                  }
                end
              end

              vim.fn.setqflist({}, " ", {
                title = "Ruby dependencies",
                items = items,
              })
              vim.cmd("copen")
            end, bufnr)
          end, {
            nargs = "?",
            force = true,
            complete = function()
              return { "all" }
            end,
          })
        end,
      })

      -- TypeScript Tools is configured once.
      -- Pass capabilities explicitly because it manages its own client.
      require("typescript-tools").setup({
        capabilities = capabilities,
        flags = lsp_flags,
      })

      vim.keymap.set("n", "<leader>tr", "<cmd>TSToolsRemoveUnusedImports<CR>", opts)
      vim.keymap.set("n", "<leader>ta", "<cmd>TSToolsAddMissingImports<CR>", opts)

      -- These inherit the shared configuration and nvim-lspconfig defaults.
      vim.lsp.enable({
        "lua_ls",
        "rust_analyzer",
        "tailwindcss",
        "graphql",
        "astro",
        "prismals",
        "mdx_analyzer",
        "eslint",
        "pyright",
        "texlab",
        "clangd",
        "ruby_lsp",
        "vue_ls",
        "glsl_analyzer",
      })
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "onsails/lspkind.nvim",
      {
        "zbirenbaum/copilot-cmp",
        dependencies = { "zbirenbaum/copilot.lua" },
        config = function()
          require("copilot_cmp").setup()
        end,
      },
      "f3fora/cmp-spell",
    },
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
            luasnip.lsp_expand(args.body)
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
              nvim_lsp_signature_help = "[Signature]",
              luasnip = "[LuaSnip]",
              copilot = "",
            },
          }),
        },
        experimental = {
          ghost_text = {
            hl_group = "LspCodeLens",
          },
        },
      })

      -- Optional buffer completion for search:
      -- cmp.setup.cmdline("/", {
      --   mapping = cmp.mapping.preset.cmdline(),
      --   sources = {
      --     { name = "buffer" },
      --   },
      -- })

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

  {
    "glepnir/lspsaga.nvim",
    branch = "main",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      {
        ",ca",
        "<cmd>Lspsaga code_action<CR>",
        desc = "Code action",
        mode = { "n", "v" },
      },
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
    cmd = "Trouble",
    opts = {},
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<CR>",
        desc = "Diagnostics",
      },
      {
        "<leader>xw",
        "<cmd>Trouble diagnostics toggle<CR>",
        desc = "Workspace diagnostics",
      },
      {
        "<leader>xd",
        "<cmd>Trouble diagnostics toggle filter.buf=0<CR>",
        desc = "Buffer diagnostics",
      },
      {
        "<leader>xl",
        "<cmd>Trouble loclist toggle<CR>",
        desc = "Location list",
      },
      {
        "<leader>xq",
        "<cmd>Trouble qflist toggle<CR>",
        desc = "Quickfix list",
      },
    },
  },

  {
    "stevearc/aerial.nvim",
    keys = {
      {
        "<leader>aa",
        "<cmd>AerialToggle!<CR>",
        desc = "AerialToggle",
      },
    },
    opts = {
      on_attach = function(bufnr)
        local opts = { buffer = bufnr }
        vim.keymap.set("n", "[[", "<cmd>AerialPrev<CR>", opts)
        vim.keymap.set("n", "]]", "<cmd>AerialNext<CR>", opts)
      end,
    },
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

  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    event = "BufReadPost",
    init = function()
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

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
