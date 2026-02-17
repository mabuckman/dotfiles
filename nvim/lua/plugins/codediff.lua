return {
  {
    "esmuellert/codediff.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    cmd = "CodeDiff",
    keys = {
      {
        "<leader>gd",
        "<cmd>VscodeDiff<cr>",
        desc = "CodeDiff explorer",
      },
      {
        "<leader>gV",
        "<cmd>CodeDiff file HEAD<cr>",
        desc = "CodeDiff current file vs HEAD",
      },
    },
    opts = {
      diff = {
        max_computation_time_ms = 5000,
        original_position = "left",
      },
    },
  },
}
