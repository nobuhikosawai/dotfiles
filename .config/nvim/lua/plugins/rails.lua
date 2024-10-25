return {
  {
    -- https://github.com/joker1007/dotfiles/blob/master/nvim/lua/plugins.lua
    "rgroli/other.nvim",
    cmd = {
      "Other",
      "OtherTabNew",
      "OtherSplit",
      "OtherVSplit",
    },
    config = function()
      local rails_controller_patterns = {
        { target = "/spec/controllers/%1_spec.rb", context = "spec" },
        { target = "/spec/requests/%1_spec.rb", context = "spec" },
        { target = "/spec/factories/%1.rb", context = "factories", transformer = "singularize" },
        { target = "/app/models/%1.rb", context = "models", transformer = "singularize" },
        { target = "/app/views/%1/**/*.html.*", context = "view" },
      }
      require("other-nvim").setup({
        mappings = {
          {
            pattern = "/app/models/(.*).rb",
            target = {
              { target = "/spec/models/%1_spec.rb", context = "spec" },
              { target = "/spec/factories/%1.rb", context = "factories", transformer = "pluralize" },
              { target = "/app/controllers/**/%1_controller.rb", context = "controller", transformer = "pluralize" },
              { target = "/app/views/%1/**/*.html.*", context = "view", transformer = "pluralize" },
            },
          },
          {
            pattern = "/spec/models/(.*)_spec.rb",
            target = {
              { target = "/app/models/%1.rb", context = "models" },
            },
          },
          {
            pattern = "/spec/factories/(.*).rb",
            target = {
              { target = "/app/models/%1.rb", context = "models", transformer = "singularize" },
              { target = "/spec/models/%1_spec.rb", context = "spec", transformer = "singularize" },
            },
          },
          {
            pattern = "/app/services/(.*).rb",
            target = {
              { target = "/spec/services/%1_spec.rb", context = "spec" },
            },
          },
          {
            pattern = "/spec/services/(.*)_spec.rb",
            target = {
              { target = "/app/services/%1.rb", context = "services" },
            },
          },
          {
            pattern = "/app/controllers/.*/(.*)_controller.rb",
            target = rails_controller_patterns,
          },
          {
            pattern = "/app/controllers/(.*)_controller.rb",
            target = rails_controller_patterns,
          },
          {
            pattern = "/app/views/(.*)/.*.html.*",
            target = {
              { target = "/spec/factories/%1.rb", context = "factories", transformer = "singularize" },
              { target = "/app/models/%1.rb", context = "models", transformer = "singularize" },
              { target = "/app/controllers/**/%1_controller.rb", context = "controller", transformer = "pluralize" },
            },
          },
          {
            pattern = "/lib/(.*).rb",
            target = {
              { target = "/spec/%1_spec.rb", context = "spec" },
              { target = "/spec/lib/%1_spec.rb", context = "spec" },
              { target = "/sig/%1.rbs", context = "sig" },
            },
          },
          {
            pattern = "/sig/(.*).rbs",
            target = {
              { target = "/lib/%1.rb", context = "lib" },
              { target = "/%1.rb" },
            },
          },
          {
            pattern = "/spec/lib/(.*)_spec.rb",
            target = {
              { target = "/lib/%1.rb", context = "lib" },
              { target = "/sig/%1.rbs", context = "sig" },
            },
          },
          {
            pattern = "/spec/(.*)_spec.rb",
            target = {
              { target = "/lib/%1.rb", context = "lib" },
              { target = "/sig/%1.rbs", context = "sig" },
            },
          },
        },
      })

      vim.keymap.set("n", "<F2>", "<cmd>OtherClear<CR><cmd>:Other<CR>")
      vim.keymap.set("n", "<F3>", "<cmd>OtherClear<CR><cmd>:Other<CR>")
      vim.keymap.set("n", "<leader>oo", "<cmd>OtherClear<CR><cmd>:Other<CR>")
      vim.keymap.set("n", "<leader>os", "<cmd>OtherClear<CR><cmd>:OtherSplit<CR>")
      vim.keymap.set("n", "<leader>ov", "<cmd>OtherClear<CR><cmd>:OtherVSplit<CR>")
      vim.keymap.set("n", "<leader>oc", "<cmd>OtherClear<CR><cmd>:OtherClear<CR>")
    end,
  },
}
