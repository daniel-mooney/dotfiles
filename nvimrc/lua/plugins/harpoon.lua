-- BUG: Opening via projects or opening directly is interpreted as different
-- buffers by Harpoon.

return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
    	"nvim-lua/plenary.nvim",
		'nvim-telescope/telescope.nvim',
    },
	config = function ()
		local which_key = require("which-key")
		local harpoon = require("harpoon")

		harpoon:setup({})

		-- Telescope integration
		local conf = require("telescope.config").values
		local function toggle_telescope(harpoon_files)
			local file_paths = {}
			-- vim.api.nvim_echo({{"Harpoon files: " .. vim.inspect(harpoon_files)}}, false, {})
			for _, item in ipairs(harpoon_files.items) do
				-- Modify the inserted value to change telescope display
				table.insert(file_paths, item.value)
			end

			require("telescope.pickers").new({}, {
				prompt_title = "Harpoon",
				finder = require("telescope.finders").new_table({
					results = file_paths,
				}),
				previewer = conf.file_previewer({}),
				sorter = conf.generic_sorter({}),
			}):find()
		end

		-- Extensions
		harpoon:extend({
			ADD = function(list_item)
				vim.notify(
					"Set harpoon " .. list_item.idx .. ": " .. list_item.item.value,
					vim.log.levels.INFO,
					{
						title = "Harpoon"
					}
				)
				-- local x = vim.inspect(list_item)
				-- vim.api.nvim_echo({{"Added to Harpoon: " .. x}}, false ,{})
			end,
			REMOVE = function(list_item)
				vim.notify(
					"Removed harpoon " .. list_item.idx,
					vim.log.levels.INFO,
					{
						title = "Harpoon"
					}
				)
				-- local x = vim.inspect(list_item)
				-- print("Removed from Harpoon:", x)
			end
		})

		-- Keymappings
		for i = 1, 9 do
			local binding = ("<leader>%d"):format(i)
			vim.keymap.set("n", binding, function() harpoon:list():select(i) end)

			-- Don't show which key hint
			which_key.add({ binding, hidden = true })
		end

		vim.keymap.set("n", "<leader>ha", function ()
			harpoon:list():add()
		end, { desc = "[H]arpoon [A]dd" })

		vim.keymap.set("n", "<leader>hr", function ()
			harpoon:list():remove()
		end, { desc = "[H]arpoon [R]emove the current file" })

		vim.keymap.set("n", "<leader>hc", function()
			harpoon:list():clear()
			vim.notify(
				"Cleared all harpoon files",
				vim.log.levels.INFO,
				{
					title = "Harpoon"
				}
			)
		end, { desc = "[H]arpoon [C]lear" })

		vim.keymap.set("n", "<leader>hq", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "[H]arpoon [Q]uick menu" })

		vim.keymap.set("n", "<leader>ht", function()
			toggle_telescope(harpoon:list())
		end, { desc = "[H]arpoon [T]oggle Telescope" })
	end
}
