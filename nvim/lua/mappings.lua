require "nvchad.mappings"

local map = vim.keymap.set

-- Normal Mode
map("n", "<C-x>", ":qall<CR>", { desc = "Save and close all windows" })
map("n", "<leader>gd", ":DiffviewOpen<CR>", { desc = "Git diff open" })
map("n", "<leader>gc", ":DiffviewClose<CR>", { desc = "Git diff close" })
map("n", "<leader>lg", ":LazyGit<CR>", { desc = "LazyGit Open" })
-- map("n", "<leader>gd", "", { desc = "" })
-- map("n", "<leader>gd", "", { desc = "" })
-- map("n", "<leader>gd", "", { desc = "" })
--map("n", "C-_>", function()
  --require("Comment.api").toggle.linewise.current()
--end, { desc = "Comment toggle" })

map("n", "C-_>", "gcc", { desc = "toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "toggle comment", remap = true })

-- Visual Mode
--map("x", "C-_>", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", { desc = "Comment toggle" })

-- Insert Mode
--
local M = {}

M.general = {
  n = {
    -- ["<C-x>"] = { ":qall<CR>", "save and close all windows", opts = { nowait = true } },
    -- ["<leader>gd"] = { ":DiffviewOpen<CR>", "git diff open" },
    -- ["<leader>gc"] = { ":DiffviewClose<CR>", "git diff close" },
    -- ["<leader>lg"] = { ":LazyGit<CR>", "lazy git open" },
    ["<leader>tt"] = {
      function()
        require("base46").toggle_transparency()
      end,
      "Toggle transparency",
    },
  },
  i = {
    ["<C-I>"] = { "<C-W>", "delete previous word", opts = { nowait = true } },
  },
}

M.comment = {
  plugin = true,

  -- toggle comment in both modes
  n = {
    ["<C-_>"] = {
      function()
        require("Comment.api").toggle.linewise.current()
      end,
      "toggle comment",
    },
  },

  v = {
    ["<C-_>"] = {
      "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
      "toggle comment",
    },
  },
}

M.telescope = {
  n = {
    ["<leader>ss"] = { "<cmd> Telescope spell_suggest <CR>", "spell suggest" },
  },
}

-- return M
