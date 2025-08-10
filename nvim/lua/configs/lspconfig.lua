require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "ts_ls", "clangd", "pyright", "dockerls", "terraformls" }

vim.lsp.enable(servers)
