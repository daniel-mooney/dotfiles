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

		-- Set keymaps
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
		end, { desc = "[H]arpoon [C]lear" })

		-- Telescope integration
		local conf = require("telescope.config").values
		local function toggle_telescope(harpoon_files)
			local file_paths = {}
			for _, item in ipairs(harpoon_files.items) do
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

		vim.keymap.set("n", "<leader>hw", function()
			toggle_telescope(harpoon:list())
		end, { desc = "[H]arpoon [W]indow" })
	end
}
