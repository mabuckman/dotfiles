return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      ["json"] = { "prettier" },
      ["jsonc"] = { "prettier" },
      ["python"] = { "ruff_format" },
      -- You can add other formatters here
      -- lua = { "stylua" },
    },
    formatters = {
      ruff_format = {
        append_args = { "--line-length", "120" },
      },
    },
  },
}
