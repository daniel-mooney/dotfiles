---------------------------------------
-- Encoding
---------------------------------------
vim.scriptencoding = "utf-8"
vim.o.encoding = "utf-8"
vim.o.fileencoding = "utf-8"

---------------------------------------
-- Appearance
---------------------------------------
vim.o.number = true			   		-- Show line numbers
vim.o.relativenumber = true			-- Show relative numbered lines
vim.o.numberwidth = 4				-- Set number column width (default: 4)
vim.opt.signcolumn = "yes:1"		-- Include sign column for nicer git appearance (default: auto)

vim.o.cursorline = true				-- Highlight the cursorline (default: false)
vim.o.pumheight = 10				-- Set Pop up menu height (default: 0)

vim.o.wrap = true					-- Wrap lines
vim.o.linebreak = true				-- Don't split words across lines (default: false)

vim.o.scrolloff = 10				-- Min padding above/below cursor
---------------------------------------
-- Typing
---------------------------------------
vim.o.tabstop = 4					-- Number of spaces for a tab (default: 8)
vim.o.shiftwidth = 0				-- Use vim.o.tabstop for shift width (default: 8)

vim.o.autoindent = true
vim.o.smartindent = true
vim.o.expandtab = false				-- Expand tabs to spaces
vim.o.smarttab = true				-- Insert indentation equal to shiftwidth at start of a line.

vim.opt.backspace = { "start", "eol", "indent" }

vim.opt.mouse = ""					-- Disable mouse support

-- Automatically go into insert mode when a new file is created.
vim.api.nvim_create_autocmd("BufNewFile", {
	callback = function ()
		vim.cmd("startinsert")
	end
})

---------------------------------------
-- Navigation
---------------------------------------
vim.opt.splitright = true

---------------------------------------
-- Diagnostics
---------------------------------------
vim.diagnostic.config({
	signs = true,
	underline = true,
	severity_sort = true,
	update_in_insert = false,

	virtual_text = {
		spacing = 4,
		prefix = "●",
		source = false,
	},

	float = {
		border = "rounded",
		focusable = false,
	}
})

-------------------------------------
-- Buffers + Registers
-----------------------------------
-- vim.o.clipboard = 'unnamedplus'		-- Sync clipboard between OS and Neovim (default: ''). Requires `xclip` installed.
