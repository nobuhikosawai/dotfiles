return {
  {
    "L3MON4D3/LuaSnip",
    config = function()
      -- short hand is from https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#adding-snippets
      local ls = require("luasnip")
      local s = ls.snippet
      local t = ls.text_node
      local i = ls.insert_node

      ls.add_snippets("typescript", {
        s("accinit", {
          t({
            'import * as fs from "fs";',
            "",
            'const inputs = fs.readFileSync("/dev/stdin", "utf-8").trim().split("\\n");',
            "",
          }),
          i(1),
        }),
      })
    end,
  },
}
