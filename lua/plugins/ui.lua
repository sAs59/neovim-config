-- local colors = {
-- 	blue = "#80a0ff",
-- 	cyan = "#79dac8",
-- 	black = "#080808",
-- 	white = "#c6c6c6",
-- 	red = "#ff5189",
-- 	violet = "#d183e8",
-- 	grey = "#303030",
-- }
--
-- local bubbles_theme = {
-- 	normal = {
-- 		a = { fg = colors.black, bg = colors.violet },
-- 		b = { fg = colors.white, bg = colors.grey },
-- 		c = { fg = colors.white },
-- 	},
--
-- 	insert = { a = { fg = colors.black, bg = colors.blue } },
-- 	visual = { a = { fg = colors.black, bg = colors.cyan } },
-- 	replace = { a = { fg = colors.black, bg = colors.red } },
--
-- 	inactive = {
-- 		a = { fg = colors.white, bg = colors.black },
-- 		b = { fg = colors.white, bg = colors.black },
-- 		c = { fg = colors.white },
-- 	},
-- }

return {
	{
		"b0o/incline.nvim",
		config = function()
			local helpers = require("incline.helpers")
			local devicons = require("nvim-web-devicons")
			require("incline").setup({
				window = {
					padding = 0,
					margin = { horizontal = 0 },
				},
				render = function(props)
					local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
					if filename == "" then
						filename = "[No Name]"
					end
					local ft_icon, ft_color = devicons.get_icon_color(filename)
					local modified = vim.bo[props.buf].modified
					return {
						ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) }
							or "",
						" ",
						{ filename, gui = modified and "bold,italic" or "bold" },
						" ",
						guibg = "#44406e",
					}
				end,
			})
		end
	},
	{
		"rcarriga/nvim-notify",
		opts = {
			stages = "fade",
			render = "compact",
		},
	},
	{
		"folke/noice.nvim",
		opts = {
			lsp = {
				progress = {
					enabled = false,
				},
			},
		},
	},
	{
		"j-hui/fidget.nvim",
		opts = {
			notification = {
				window = {
					winblend = 0,
					relative = "editor",
				},
			},
		},
	},
	{
		"catppuccin/nvim",
		opts = {
			custom_highlights = function(colors)
				return {
					NeoTreeNormal = { bg = colors.none }, -- Set to a color from the Catppuccin palette
					NeoTreeNormalNC = { bg = colors.none }, -- Unfocused background color
				}
			end,
		},
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		opts = {
			size = 80,
			open_mapping = [[<c-\>]],
			direction = "vertical",
			shade_terminals = false,
		},
	},
	-- {
	-- 	"nvim-lualine/lualine.nvim",
	-- 	opts = function()
	-- 		-- PERF: we don't need this lualine require madness 🤷
	-- 		local lualine_require = require("lualine_require")
	-- 		lualine_require.require = require
	--
	-- 		local icons = LazyVim.config.icons
	--
	-- 		vim.o.laststatus = vim.g.lualine_laststatus
	--
	-- 		local opts = {
	-- 			options = {
	-- 				theme = "auto",
	-- 				-- theme = bubbles_theme,
	-- 				globalstatus = vim.o.laststatus == 3,
	-- 				disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter" } },
	-- 				component_separators = "",
	-- 				section_separators = { left = "", right = "" },
	-- 			},
	-- 			sections = {
	-- 				lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
	-- 				lualine_b = { "branch" },
	-- 				lualine_c = {
	-- 					LazyVim.lualine.root_dir(),
	-- 					{
	-- 						"diagnostics",
	-- 						symbols = {
	-- 							error = icons.diagnostics.Error,
	-- 							warn = icons.diagnostics.Warn,
	-- 							info = icons.diagnostics.Info,
	-- 							hint = icons.diagnostics.Hint,
	-- 						},
	-- 					},
	-- 					{ LazyVim.lualine.pretty_path({ length = 7 }) },
	-- 				},
	--
	-- 				lualine_x = {
	-- 					{
	-- 						"diff",
	-- 						symbols = {
	-- 							added = icons.git.added,
	-- 							modified = icons.git.modified,
	-- 							removed = icons.git.removed,
	-- 						},
	-- 						source = function()
	-- 							local gitsigns = vim.b.gitsigns_status_dict
	-- 							if gitsigns then
	-- 								return {
	-- 									added = gitsigns.added,
	-- 									modified = gitsigns.changed,
	-- 									removed = gitsigns.removed,
	-- 								}
	-- 							end
	-- 						end,
	-- 					},
	-- 				},
	-- 				lualine_y = { "filetype", "progress" },
	-- 				lualine_z = {
	-- 					{ "location", separator = { right = "" }, left_padding = 2 },
	-- 				},
	-- 			},
	-- 			inactive_sections = {
	-- 				lualine_a = { "filename" },
	-- 				lualine_b = {},
	-- 				lualine_c = {},
	-- 				lualine_x = {},
	-- 				lualine_y = {},
	-- 				lualine_z = { "location" },
	-- 			},
	-- 			tabline = {},
	-- 			extensions = { "lazy" },
	-- 		}
	--
	-- 		return opts
	-- 	end,
	-- },
}
