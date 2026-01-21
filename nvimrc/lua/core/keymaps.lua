-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

------------------------------------
-- Text manipulation
------------------------------------

-- System register operations
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])	-- Yank
vim.keymap.set({"n", "v"}, "<leader>Y", [["+Y]])	-- Yank line
vim.keymap.set("n", "<leader>p", [["+p]])			-- Put

-- Registerless operations
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])	-- Delete
vim.keymap.set("x", "<leader>P", [["_dP]])			-- Put
vim.keymap.set("n", "x", '"_x')						-- Char into the void

-- Move highlighted blocks up and down
vim.keymap.set("v", "<NL>", ":m '>+1<CR>gv=gv")		-- '> is line number of the end of the selection
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv")

-- Move current line down / up (normal mode)
vim.keymap.set("n", "<NL>", ":m .+1<CR>==", { remap = true, desc = "Move line down" })	-- <NL> is <C-j>
vim.keymap.set("n", "<C-k>", ":m .-2<CR>==", { remap = true, desc = "Move line up" })

-- Comments
-- Toggles a comment on a line if it contains text, else creates a new comment.
local function comment_or_insert()
	local bufnr = 0
	local row = vim.api.nvim_win_get_cursor(0)[1] -- 1-based
	local line = vim.api.nvim_get_current_line()

	-- Empty/whitespace-only line: insert comment leader with proper indent, then startinsert!.
	if line:match("^%s*$") then
		local indent = line:match("^(%s*)") or ""
		if indent == "" then
			-- Use Neovim's indentexpr/cindent/etc if available (falls back to 0)
			local ind = vim.fn.indent(row)
			if ind > 0 then indent = string.rep(" ", ind) end
		end

		local cs = vim.bo[bufnr].commentstring
		if not cs or cs == "" or not cs:find("%%s") then
			-- No usable commentstring; just indent + start typing
			vim.api.nvim_set_current_line(indent)
			vim.api.nvim_win_set_cursor(0, { row, #indent })
			vim.cmd("startinsert!")
			return
		end

		local left, right = cs:match("^(.-)%%s(.-)$")
		left = (left or ""):gsub("%s+$", "")
		right = (right or ""):gsub("^%s+", "")

		if right ~= "" then
			-- Block-style: put cursor between left and right
			local text = indent .. left .. " " .. right
			vim.api.nvim_set_current_line(text)
			vim.api.nvim_win_set_cursor(0, { row, #indent + #left + 1 })
			vim.cmd("startinsert!")
		else
			-- Line-style: add trailing space and type
			local text = indent .. left .. " "
			vim.api.nvim_set_current_line(text)
			vim.api.nvim_win_set_cursor(0, { row, #text })
			vim.cmd("startinsert!")
		end
		return
	end

	-- Non-empty line: delegate to your plugin mapping ("gc_") via a *remappable* normal-mode call.
	-- Using :normal! bypasses mappings; we want mappings, so use :normal (not !).
	vim.cmd("normal gc_")
end

vim.keymap.set("n", "<leader>;", comment_or_insert, { remap = true, desc = "Toggle comment" })
vim.keymap.set("x", "<leader>;", "gcgv", { remap = true, desc = "Toggle comment" })		-- Stays in visual block selection mode
vim.keymap.set("n", "gcc", "<Nop>")

------------------------------------
-- Navigation
------------------------------------
vim.keymap.set("n", "<C-d>", "<C-d>zz")		-- Keep cursor centered when half page scrolling
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "n", "nzzzv")			-- Center cursor when searching
vim.keymap.set("n", "N", "Nzzzv")

-- Undo/Redo jumps
vim.keymap.set("n", "<leader>,", "<C-o>", { noremap = true })
vim.keymap.set("n", "<leader>.", "<C-i>", { noremap = true })

vim.keymap.set("n", "<leader>q", ":cclose<CR>", { desc = "Close quickfix menu" })

vim.keymap.set("n", "<leader>x", ":Ex<CR>", { desc = "Open netrw in the current file's directory" })
vim.keymap.set("n", "<leader>X", function ()
	vim.cmd("Explore " .. vim.fn.getcwd())
end, { desc = "Open netrw in the current working directory" })
------------------------------------
-- Diagnostics
------------------------------------

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)

-- Remap diagnostic pan through keys to also open the associated float box
vim.keymap.set("n", "]d", function ()
	vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Next diagnostic + show"})

vim.keymap.set("n", "[d", function ()
	vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Last diagnostic + show"})
