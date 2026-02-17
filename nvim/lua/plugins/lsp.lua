return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = {
        enabled = false, -- Disable inlay hints globally
      },
      servers = {
        basedpyright = {
          settings = {
            basedpyright = {
              analysis = {
                inlayHints = {
                  variableTypes = false,
                  functionReturnTypes = false,
                  parameterTypes = false,
                },
              },
            },
          },
        },
        ruff = {},
        marksman = { enabled = false }, -- disable markdown LSP
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        markdown = {}, -- disable markdownlint for markdown files
      },
    },
  },
}
