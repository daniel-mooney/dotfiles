return {
	'nvim-mini/mini.nvim',
	version = false,
	config = function ()
		-------------------------------
		--- Misc
		-------------------------------
		require('mini.pairs').setup({})
		require('mini.splitjoin').setup({})
		require('mini.move').setup({})

		------------------------------
		--- Completion
		------------------------------
		require('mini.snippets').setup({})
		require('mini.icons').setup({})
		MiniIcons.tweak_lsp_kind()

		require('mini.completion').setup({
			delay = {
				completion = 100,
				info = 100,
				signature = 50,
			}
		})

		-- Define keymappings for completion
		local imap_expr = function(lhs, rhs)
			vim.keymap.set('i', lhs, rhs, { expr = true })
		end

		imap_expr('<Tab>',   [[pumvisible() ? "\<C-n>" : "\<Tab>"]])
		imap_expr('<C-j>',   [[pumvisible() ? "\<C-n>" : "\<Tab>"]])
		imap_expr('<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]])
		imap_expr('<C-k>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]])

		-- <CR> behaviour function
		local function cr_action()
			local info = vim.fn.complete_info({ 'selected', 'items' })
			local selected = info.selected
			if selected == -1 then
				return MiniPairs.cr()
			end
			local item = info.items[selected + 1]
			local kind = (item and item.kind or ''):match('[%a]+$') or ''

			if kind == 'Function' or kind == 'Method' or kind == 'Constructor' then
				local clients = vim.lsp.get_clients({ bufnr = 0 })
				local has_clangd = vim.iter(clients):any(function(c) return c.name == 'clangd' end)
				local has_rust_analyzer = vim.iter(clients):any(function(c) return c.name == 'rust_analyzer' end)
				local is_macro = (item.word or ''):match('!$') ~= nil

				-- Hack around clangd and rust macros always sending parentheses.
				if not has_clangd and not (has_rust_analyzer and is_macro) then
					vim.schedule(function()
						vim.api.nvim_feedkeys('()' .. vim.keycode('<Left>'), 'n', false)
					end)
				end
			end
			return vim.keycode('<C-y>')
		end
		vim.keymap.set('i', '<CR>', cr_action, { expr = true })
		-- Highlight current function parameter
		vim.api.nvim_set_hl(0, 'MiniCompletionActiveParameter', {
			bg = '#3b4252',
			underline = false,
			bold = true,
		})

	end
}
