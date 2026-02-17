return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		opts = {
			custom_highlights = function(c)
				return {
					DiffAdd = { bg = "#2a3d38" },
					DiffChange = { bg = c.base },
					DiffDelete = { bg = "#3b2d36", fg = c.surface2 },
					DiffText = { bg = c.surface1 },
					DiffviewDiffAdd = { bg = "#2a3d38" },
					DiffviewDiffDelete = { bg = "#3b2d36", fg = c.surface2 },
					DiffviewDiffDeleteDim = { bg = c.base, fg = c.overlay0 },
					DiffviewDiffAddAsDelete = { bg = "#3b2d36", fg = c.surface2 },
					DiffviewStatusAdded = { fg = c.green },
					DiffviewStatusDeleted = { fg = c.red },
				}
			end,
		},
	},
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "catppuccin",
		},
	},
}
