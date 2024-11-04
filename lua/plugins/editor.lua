local function getTelescopeOpts(state, path)
	return {
		cwd = path,
		search_dirs = { path },
		attach_mappings = function(prompt_bufnr)
			local actions = require("telescope.actions")
			actions.select_default:replace(function()
				actions.close(prompt_bufnr)
				local action_state = require("telescope.actions.state")
				local selection = action_state.get_selected_entry()
				local filename = selection.filename
				if filename == nil then
					filename = selection[1]
				end
				-- any way to open the file without triggering auto-close event of neo-tree?
				require("neo-tree.sources.filesystem").navigate(state, state.path, filename)
			end)
			return true
		end,
	}
end

return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		keys = {
			{ "<leader>be", false },
			{ "<leader>ge", false },
		},
		opts = {
			hide_root_node = true,
			filesystem = {
				window = {
					mappings = {
						["tf"] = "telescope_find",
						["tg"] = "telescope_grep",
					},
				},
				commands = {
					telescope_find = function(state)
						local node = state.tree:get_node()
						local path = node:get_id()
						require("telescope.builtin").find_files(getTelescopeOpts(state, path))
					end,
					telescope_grep = function(state)
						local node = state.tree:get_node()
						local path = node:get_id()
						require("telescope.builtin").live_grep(getTelescopeOpts(state, path))
					end,
				},
				filtered_items = {
					hide_dotfiles = false,
					show_hidden_count = false,
					hide_by_name = {
						".git",
						".husky",
					},
					never_show = {
						".DS_Store",
					},
				},
			},
			-- event_handlers = {
			-- 	{
			-- 		event = "file_opened",
			-- 		handler = function()
			-- 			require("neo-tree.command").execute({ action = "close" })
			-- 		end,
			-- 	},
			-- },
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		opts = {
			defaults = {
				sorting_strategy = "ascending",
				layout_strategy = "vertical",
				layout_config = {
					prompt_position = "top",
          -- preview_cutoff = 120,
					width = 80,
					height = 0.70,
					mirror = true,
				},
				file_ignore_patterns = {
					"yarn.lock",
					"*-lock.json",
					".git/",
				},
			},
			pickers = {
				git_files = {
					theme = "dropdown",
					previewer = false,
				},
				find_files = {
					theme = "dropdown",
					previewer = false,
				},
				buffers = {
					theme = "dropdown",
					previewer = false,
				},
				live_grep = {
					debounce = 100,
					additional_args = function()
						return { "--hidden" }
					end,
				},
			},
		},
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
}
