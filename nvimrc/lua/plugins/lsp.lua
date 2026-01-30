-- `nvim-lspconfig` provides an LSP client.
-- `mason` provides LSP servers, that on their own, are incompatible with Neovim
-- `mason-lspconfig` provides a compatability bridge

return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"mason-org/mason.nvim",
			"mason-org/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp"
		},
		config = function ()
			local on_attach = function (client, bufnr)
				if client.server_capabilities.inlayHintProvider then
					vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
				end
			end

			-- Capabilities tell the LSP servers that autocompletion is supported via nvim-cmp
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					-- "rust_analyzer", 			-- Mason rust-analyzer does notmatch toolchain
					"clangd",		-- C/C++,
					"cmake",
					"basedpyright",
				},
			})
			-- Configure servers using Neovim 0.11+ API
			vim.lsp.config("lua_ls", {
				capabilities = capabilities,
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = { globals = { "vim" } },
						workspace = { checkThirdParty = false },
						telemetry = { enable = false },
					},
				},
			})

			vim.lsp.config("basedpyright", {
				capabilities = capabilities,
				settings = {
					basedpyright = {
						analysis = {
							autoSearchPaths = true,
							diagnosticMode = "openFilesOnly",
							useLibraryCodeForTypes = true,
							typeCheckingMode = "off",
							inlayHints = {
								variableTypes = true,
								callArgumentNames = false,
							}
						}
					}
				}
			})

			vim.lsp.config("clangd", {
				capabilities = capabilities,
			})

			vim.lsp.config("cmake", {
				capabilities = capabilities,
			})
			-- Issues:
			-- 	1. Inlay hints only load after first edit and no on file open.
			-- Force rust-analyzer to rustup (NOT Mason)
			vim.lsp.config("rust_analyzer", {
				cmd = { "rustup", "run", "stable", "rust-analyzer" },
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					["rust-analyzer"] = {
						cargo = {
							allFeatures = true,
							buildScripts = { enable = true },
						},
						completion = {
							callable = {
								snippets = "add_parentheses",		-- Don't send placeholder arg names
							},
						},
						inlayHints = {
							typeHints = { enable = true },
							parameterHints = { enable = false },
							closingBraceHints = { enable = true, minLines = 20 },
						},
					}
				},
			})

			-- Enable them
			vim.lsp.enable({
				"lua_ls",
				"clangd",
				"cmake",
				"rust_analyzer",
				"basedpyright",
			})

			-- vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { silent = true })
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "vim.lsp.buf.definition()" })
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "vim.lsp.buf.declaration()" })

			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "vim.lsp.buf.rename()" })

			vim.keymap.set("n", "<leader>li", function()
				local bufnr = vim.api.nvim_get_current_buf()
				local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
				vim.lsp.inlay_hint.enable(not enabled, { bufnr = bufnr })
			end, { desc = "Toggle inlay hints" })
		end
	},

	-- Autocompletion UI
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			-- "hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-emoji",
			"onsails/lspkind.nvim",
		},
		config = function()
			local cmp = require("cmp")
			local lspkind = require("lspkind")

			cmp.setup({
				mapping = cmp.mapping.preset.insert({
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping.select_next_item(),
					["<S-Tab>"] = cmp.mapping.select_prev_item(),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path" },
					{ name = "emoji"}
					-- { name = "nvim_lsp_signature_help" },	-- Cannot toggle... always shows
					-- { name = "luasnip" },		-- if snippets are enabled
				}),
				formatting = {
					fields = { 'abbr', 'icon', 'kind', 'menu' },
					format = lspkind.cmp_format({
						maxwidth = {
							-- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
							-- can also be a function to dynamically calculate max width such as
							-- menu = function() return math.floor(0.45 * vim.o.columns) end,
							menu = 50, -- leading text (labelDetails)
							abbr = 50, -- actual suggestion item
						},
						ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
						show_labelDetails = true, -- show labelDetails in menu. Disabled by default

						-- The function below will be called before any actual modifications from lspkind
						-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
						before = function (entry, vim_item)
							-- ...
							return vim_item
						end
					})
				},
			})
			end
		},
	-- -- LSP signature help
	-- {
	-- 	"ray-x/lsp_signature.nvim",
	-- 	event = "InsertEnter",
	-- 	config = function ()
	-- 		require('lsp_signature').setup({
	-- 			debug = true,
	-- 			verbose = false,
	-- 			toggle_key = "<M-k>",		-- for insert mode only
	-- 			doc_lines = 10,
	-- 			max_height = 12,
	-- 			always_trigger = true,
	-- 			hint_enable = false,
	-- 			fix_pos = true,
	-- 		})
	--
	-- 		-- -- Monkey patching: Keep sig float box fixed when spreading
	-- 		-- -- func args over multiple lines. Previously, it would close
	-- 		-- -- and re-render when <Enter> is pressed.
	-- 		--
	-- 		-- -- TODO: Have float open above the function name, not the cursor
	-- 		-- -- At the moment, it is tricky to edit up since the float box
	-- 		-- -- does not move up with the cursor and initially renders 
	-- 		-- -- on top of the function.
	-- 		-- local helper = require('lsp_signature.helper')
	-- 		--
	-- 		-- -- Hide the occurance of a new line
	-- 		-- helper.is_new_line = function ()
	-- 			-- 	return false
	-- 			-- end
	-- 			--
	-- 			-- -- Close `)` of a func is a trigger char
	-- 			-- local orig_check_trigger_char = helper.check_trigger_char
	-- 			-- helper.check_trigger_char = function(line_to_cursor, trigger_chars)
	-- 				-- 	-- If we've passed the matching ')', force close
	-- 				-- 	local opens, closes = 0, 0
	-- 				-- 	for c in line_to_cursor:gmatch(".") do
	-- 				-- 		if c == "(" then opens = opens + 1 end
	-- 				-- 		if c == ")" then closes = closes + 1 end
	-- 				-- 	end
	-- 				--
	-- 				-- 	if closes > opens then
	-- 				-- 		return false, #line_to_cursor
	-- 				-- 	end
	-- 				--
	-- 				-- 	return orig_check_trigger_char(line_to_cursor, trigger_chars)
	-- 				-- end
	-- 	end
	-- }
}
