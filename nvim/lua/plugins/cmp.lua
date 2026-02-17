return {
  "saghen/blink.cmp",
  opts = {
    enabled = function()
      -- Disable in specific filetypes
      local disabled_filetypes = {
        "opencode_ask",
        -- Add other filetypes you want to disable here
        -- "TelescopePrompt",
        -- "neo-tree",
      }

      local filetype = vim.bo.filetype
      for _, ft in ipairs(disabled_filetypes) do
        if ft == filetype then
          return false
        end
      end

      -- Optionally disable in specific buffer types
      local buftype = vim.bo.buftype
      if buftype == "prompt" then
        return false
      end

      return true
    end,
  },
}
