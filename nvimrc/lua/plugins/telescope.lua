return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
		-- Improve sorting performance
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
		-- Add pretty icons
		{ 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
	config = function()
		local actions = require('telescope.actions')

		local ignore_ft = {
			-- rust
			"target/", "%.lock$",
			-- python
			"__pycache__/", "%.pyc",
		}

		require('telescope').setup({
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
			}
		})

		local builtin = require('telescope.builtin')

		vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
		vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
		vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
		vim.keymap.set('n', '<leader>sg', builtin.git_files, { desc = "[S]earch [G]it Files"})
		vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
		vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
		vim.keymap.set('n', '<leader>sp', builtin.live_grep, { desc = '[S]earch by Grep [P]attern' })
		vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
		vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
		vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
		vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
	end
}
