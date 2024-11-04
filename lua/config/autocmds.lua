-- Disable diagnostic for css file in a current buffer
-- vim.api.nvim_create_autocmd({ "FileType" }, {
-- 	pattern = { "css" },
-- 	callback = function()
-- 		vim.diagnostic.enable(false)
-- 	end,
-- })

-- Remove trailing white space
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = { "*" },
	callback = function()
		local save_cursor = vim.fn.getpos(".")
		pcall(function()
			vim.cmd([[%s/\s\+$//e]])
		end)
		vim.fn.setpos(".", save_cursor)
	end,
})

