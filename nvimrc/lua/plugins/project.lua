-- Bug: Some plugins require setup() to be called each time nvim is opened
-- in a new directory. This is done when starting a new nvim instance. Changing
-- working directories while remaining inside nvim bypasses this process
-- and cause issues.

return {
	"ahmedkhalf/project.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		'stevearc/oil.nvim',
	},
	config = function()
		require("project_nvim").setup({
			manual_mode = false,
			detection_methods = { "pattern" },
			patterns = {
				".git", "Makefile", "platformio.ini", "pyproject.toml",
				"Cargo.toml", "compile_commands.json",
			},
		})

		local telescope = require("telescope")
		telescope.load_extension("projects")

		local original_projects = telescope.extensions.projects.projects

		local function project_picker_oil(opts)
			opts = opts or {}

			local actions = require("telescope.actions")
			local action_state = require("telescope.actions.state")

			opts.attach_mappings = function(prompt_bufnr, map)
				actions.select_default:replace(function()
					local selection = action_state.get_selected_entry()
					actions.close(prompt_bufnr)

					if not selection then
						return
					end

					local project_path = selection.value or selection.path or selection[1]
					if not project_path then
						return
					end

					vim.cmd.cd(project_path)
					require("oil").open(project_path)
				end)

				return true
			end

			return original_projects(opts)
		end

		telescope.extensions.projects.projects = project_picker_oil
	end,
}
