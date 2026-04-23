-- `nvim-lspconfig` provides an LSP client.
-- `mason` provides LSP servers, that on their own, are incompatible with Neovim
-- `mason-lspconfig` provides a compatability bridge

return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"mason-org/mason.nvim",
			"mason-org/mason-lspconfig.nvim",
		},
		config = function ()
			local on_attach = function (client, bufnr)
				if client.server_capabilities.inlayHintProvider then
					vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
				end
			end

			-- Capabilities tell the LSP servers that autocompletion is supported via nvim-cmp
			local capabilities = vim.lsp.protocol.make_client_capabilities()

			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					-- "rust_analyzer", 			-- Mason rust-analyzer does notmatch toolchain
					"clangd",		-- C/C++,
					"cmake",
					"basedpyright",
					"lemminx",
				},
				automatic_enable = false,
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

			-- Nvim LSP has no callback for modifying cmd.
			-- Need to manually launch clangd

			-- vim.lsp.config("clangd", {
			-- 	capabilities = capabilities,
			-- 	cmd = {
			-- 		"clangd",
			-- 		"--function-arg-placeholders=false",
			-- 		"--compile-commands-dir=/home/daniel-mooney/Documents/Code/Embedded/stm32-rtos"
			-- 	},
			-- })

			local function clangd_project_root(bufnr)
				local fname = vim.api.nvim_buf_get_name(bufnr)

				-- Root is a parent dir containing compile_commands or .git
				local root = vim.fs.root(fname, {
					"compile_commands.json",
					".git",
				})
				if root then
					return root
				end

				-- Second: if this file lives outside the project tree, reuse an existing
				-- clangd project's root if one already exists.
				for _, client in ipairs(vim.lsp.get_clients({ name = "clangd" })) do
					if client.config.root_dir then
						return client.config.root_dir
					end
				end

				-- Last fallback. Root is CWD
				return vim.fn.getcwd()
			end

			-- Launch clangd on certain files opening
			local clang_ext = { "c", "cpp", "objc", "objcpp", "arduino" };

			vim.api.nvim_create_autocmd("FileType", {
				pattern = clang_ext,
				callback = function(args)
					local root = clangd_project_root(args.buf)
					-- vim.notify("Starting clangd with root: "..root)
					vim.lsp.start({
						name = "clangd",
						cmd = {
							"clangd",
							"--function-arg-placeholders=false",
							"--compile-commands-dir=" .. root,
						},
						root_dir = root,

						-- Important: reuse the existing clangd client for the same project root.
						-- reuse_client = function(client, config)
						-- 	return client.name == "clangd"
						-- 		and client.config.root_dir == config.root_dir
						-- end,
					})
				end,
			})

			-- Format c 
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = clang_ext,
				callback = function()
					vim.lsp.buf.format({ async = false })
				end,
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
								snippets = "none",
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

			vim.lsp.config("lemminx", {
				capabilities=capabilities,
				filetypes = {
					"xml","xsd", "xsl", "xslt", "svg", "urdf", "xacro", "sdf"
				}
			})

			-- Enable them
			vim.lsp.enable({
				"lua_ls",
				-- "clangd",
				"cmake",
				"rust_analyzer",
				"basedpyright",
				"lemminx",
			})

			vim.filetype.add({
				extension = {
					rviz = "yaml",
					clangd = 'yaml',
				},
			})

			-- Keymaps

			-- vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { silent = true })
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })

			vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename item" })

			vim.keymap.set("n", "<leader>li", function()
				local bufnr = vim.api.nvim_get_current_buf()
				local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
				vim.lsp.inlay_hint.enable(not enabled, { bufnr = bufnr })
			end, { desc = "Toggle inlay hints" })

			vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format File" })
		end
	},
}
