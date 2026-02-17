-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local codediff_group = vim.api.nvim_create_augroup("codediff_local", { clear = true })

local function hide_codediff_unnamed_buffers(tabpage)
  local ok_lifecycle, lifecycle = pcall(require, "codediff.ui.lifecycle")
  if not ok_lifecycle then
    return
  end

  local session = lifecycle.get_session(tabpage)
  if not session then
    return
  end

  local function hide_buf(buf)
    if not buf or not vim.api.nvim_buf_is_valid(buf) then
      return
    end
    if vim.api.nvim_buf_get_name(buf) == "" and vim.bo[buf].buftype == "" then
      vim.bo[buf].buflisted = false
    end
  end

  hide_buf(session.original_bufnr)
  hide_buf(session.modified_bufnr)
  hide_buf(session.result_bufnr)

  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tabpage)) do
    hide_buf(vim.api.nvim_win_get_buf(win))
  end
end

vim.api.nvim_create_autocmd("FileType", {
  group = codediff_group,
  pattern = "codediff-explorer",
  callback = function(args)
    vim.defer_fn(function()
      hide_codediff_unnamed_buffers(vim.api.nvim_get_current_tabpage())
    end, 80)

    vim.keymap.set("n", "<CR>", function()
      local ok_lifecycle, lifecycle = pcall(require, "codediff.ui.lifecycle")
      if not ok_lifecycle then
        return
      end

      local tabpage = vim.api.nvim_get_current_tabpage()
      local explorer = lifecycle.get_explorer(tabpage)
      if not explorer or explorer.bufnr ~= args.buf or not explorer.tree then
        return
      end

      local line = vim.api.nvim_win_get_cursor(0)[1]
      local node = explorer.tree:get_node(line)
      if not node or not node.data then
        return
      end

      if node.data.type == "group" or node.data.type == "directory" then
        if node:is_expanded() then
          node:collapse()
        else
          node:expand()
        end
        explorer.tree:render()
        return
      end

      explorer.on_file_select({
        path = node.data.path,
        old_path = node.data.old_path,
        status = node.data.status,
        git_root = node.data.git_root,
        group = node.data.group,
      })
    end, { buffer = args.buf, noremap = true, silent = true, nowait = true, desc = "CodeDiff select file" })

    vim.b[args.buf].codediff_last_hover_line = 0

    vim.api.nvim_create_autocmd("CursorMoved", {
      group = codediff_group,
      buffer = args.buf,
      callback = function()
        local ok_lifecycle, lifecycle = pcall(require, "codediff.ui.lifecycle")
        if not ok_lifecycle then
          return
        end

        local tabpage = vim.api.nvim_get_current_tabpage()
        local explorer = lifecycle.get_explorer(tabpage)
        if not explorer or explorer.bufnr ~= args.buf or not explorer.tree then
          return
        end

        local line = vim.api.nvim_win_get_cursor(0)[1]
        if vim.b[args.buf].codediff_last_hover_line == line then
          return
        end
        vim.b[args.buf].codediff_last_hover_line = line

        local node = explorer.tree:get_node(line)
        if not node or not node.data then
          return
        end

        if node.data.type == "group" or node.data.type == "directory" then
          return
        end

        explorer.on_file_select({
          path = node.data.path,
          old_path = node.data.old_path,
          status = node.data.status,
          git_root = node.data.git_root,
          group = node.data.group,
        })
      end,
    })
  end,
})
