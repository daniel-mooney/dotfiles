return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
		'nvim-telescope/telescope-frecency.nvim',
		-- Improve sorting performance
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
		-- Add pretty icons
		{ 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
	config = function()
		-- TODO: Added frecency like functionality for all pickers

		local telescope = require('telescope')
		local actions = require('telescope.actions')

		local ignore_ft = {
			-- rust
			"target/", "%.lock$",
			-- python
			"__pycache__/", "%.pyc",
		}

		telescope.setup({
			defaults = {
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
						["<C-l>"] = actions.select_default,
						["<esc>"] = actions.close
					}
				},
				file_ignore_patterns = ignore_ft,
			},
			extensions = {
				frecency = {
					show_scores = false,
					show_unindexed = true,
					ignore_patterns = ignore_ft,
					matcher = "fuzzy",
					scoring_function = function(recency, fzy_score)
						local w_recency = 1
						local w_fzf = 1

						local score = (w_recency / (recency == 0 and 1 or recency)) - w_fzf / fzy_score
						return score == -1 and -1.000001 or score
					end
				}
			}
		})

		telescope.load_extension('frecency')
		telescope.load_extension('notify')

		local builtin = require('telescope.builtin')

		vim.keymap.set("n", "<leader>sf", function()
			telescope.extensions.frecency.frecency({
				workspace = "CWD",
			})
		end, { desc = "[S]earch [F]iles (frecency)" })

		-- vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
		vim.keymap.set('n', '<leader>sg', builtin.grep_string, { desc = "[S]earch [G]rep pattern"})
		vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
		vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
		vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
		vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
		vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
		vim.keymap.set('n', '<leader>s<leader>', builtin.resume, { desc = '[S]earch [R]esume' })
		vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
		vim.keymap.set('n', '<leader>sn', telescope.extensions.notify.notify, { desc = "[S]earch [N]otifications"})

		vim.keymap.set('n', '<leader>sm', function ()
			require('telescope.builtin').man_pages({
				sections = { "ALL" },
			})
		end, { desc = "[S]earch [M]an pages"})

		-- vim.keymap.set('n', '<leader>sr', builtin.lsp_references, { desc = "[S]earch [R]eferences"})
		-- vim.keymap.set('n', '<leader>sp', ":Telescope projects <CR>" , { desc = '[S]earch [P]rojects' })
	end
}
