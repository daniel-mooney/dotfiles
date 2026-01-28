return {
	{
		"folke/tokyonight.nvim",
		lazy = true,
		priority = 1000,
		opts = {},
		config = function()
			require("tokyonight").setup({
				style = "moon",			-- "storm", "moon", "night" or "day"
				transparent = false,
				terminal_colors = true,		-- Configures colors used when opening a :terminal in neovim
				styles = {
					comments = { italic = true },
					keywords = { italic = false },
					-- Background styles. Can be "dark", "transparent" or "normal"
					sidebars = "dark",
					floats = "dark",
				},
			})
			-- set the color theme
			-- vim.cmd.colorscheme("tokyonight")

			-- Customizations
			-- vim.api.nvim_set_hl(0, "LineNr", { fg = "#ffffff" })				-- For absolute line numbers

			-- For relative line numbers
			vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#aba69f" })
			vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#aba69f" })

			-- vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#ffffff", bold = true })
		end
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		config = function ()
			require("catppuccin").setup({
				flavour = "macchiato",
				styles = {
					comments = { "italic" },
					strings = { "italic" },
				},
				dim_inactive = {
					enabled = false,
					shade = "dark",
					percentage = 0.15
				},
			})

			vim.cmd.colorscheme("catppuccin")


			-- For relative line numbers
			vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#aba69f" })
			vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#aba69f" })
		end
	},
}
