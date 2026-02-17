return {
  "folke/snacks.nvim",
  opts = {
    terminal = {
      win = {
        keys = {
          nav_l = { "<C-l>", function()
            return "<C-l>"
          end, desc = "Clear Terminal", expr = true, mode = "t" },
        },
        wo = {
          winbar = "",
        },
      },
    },
  },
}
