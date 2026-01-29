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
	local line = vim.api.nvim_get_current_line()

	if line:match('^%s*$') then
		local cs = vim.bo.commentstring
		if cs == "" or not cs:find("%%s") then cs = "# %s" end

		local left, right = cs:match("^(.-)%%s(.-)$")
		local keys = vim.api.nvim_replace_termcodes(
			string.format([["_cc%s %s]], left, right), true, false, true
		)
		vim.api.nvim_feedkeys(keys, "n", false)

		if #right > 0 then
			local back = vim.api.nvim_replace_termcodes(string.rep("<Left>", #right + 1), true, false, true)
			vim.api.nvim_feedkeys(back, "n", false)
		end
	else
		vim.cmd("normal gc_")
	end
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

-- Jump to indentation level on empty line
vim.keymap.set("n", "I", function ()
	if vim.fn.getline('.'):match('^%s*$') then
		return [["_cc]]
	else
		return "I"
	end
end, { expr = true, silent = true, desc = "Smart indenton empty line, else normal I" })

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
