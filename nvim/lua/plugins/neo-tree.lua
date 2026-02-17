return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      { "<leader>e", false },
      {
        "<leader>e",
        function()
          local ok_lifecycle, lifecycle = pcall(require, "codediff.ui.lifecycle")
          if ok_lifecycle then
            local tabpage = vim.api.nvim_get_current_tabpage()
            local session = lifecycle.get_session(tabpage)
            if session then
              local explorer_obj = lifecycle.get_explorer(tabpage)
              if explorer_obj then
                local ok_explorer, explorer = pcall(require, "codediff.ui.explorer")
                if ok_explorer and explorer.toggle_visibility then
                  explorer.toggle_visibility(explorer_obj)
                  return
                end
              end
              return
            end
          end

          local keys = vim.api.nvim_replace_termcodes("<leader>fe", true, false, true)
          vim.api.nvim_feedkeys(keys, "m", false)
        end,
        desc = "Explorer",
      },
    },
    opts = function(_, opts)
      opts.window = opts.window or {}
      opts.window.mappings = opts.window.mappings or {}
      opts.window.mappings["<C-x>"] = function()
        vim.cmd("qa")
      end
    end,
  },
}
