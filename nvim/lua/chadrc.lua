---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "highlights"

M.base46 = {
--   theme_toggle = { "onedark", "one_light" },
  theme = "onedark",
--   hl_override = highlights.override,
--   hl_add = highlights.add,
--
--   transparency = true,
}
--
-- M.plugins = "plugins"
M.nvdash = {
  load_on_startup = true,
}

-- check core.mappings for table structure
-- M.mappings = require "mappings"

return M
