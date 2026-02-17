-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<C-x>", "<cmd>qa<cr>", { desc = "Quit all" })

vim.keymap.set("n", "<leader>e", function()
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
end, { desc = "Explorer" })
