return {
  {
    "nvim-orgmode/orgmode",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter", lazy = true },
    },
    event = "VeryLazy",
    config = function()
      -- Setup orgmode
      require("orgmode").setup({
        org_agenda_files = "~/Dropbox/Personal/note/org-mode/**/*",
        org_default_notes_file = "~/Dropbox/Personal/note/org-mode/index.org",
      })
    end,
  },
}
