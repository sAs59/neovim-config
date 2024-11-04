local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set("n", "U", "<C-r>", opts)

keymap.set("n", "x", '"_x')

-- Increment/Decremenet
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Allow deleting on insert mode
keymap.set("i", "<C-d>", "<C-o>x", opts)

-- Fix shift space
keymap.set("i", "<S-Space>", "<Space>", opts)

-- Inserting blank lines before and after current line
keymap.set("n", "gO", "<Cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>")
keymap.set("n", "go", "<Cmd>call append(line('.'),     repeat([''], v:count1))<CR>")

-- Copy buffer path
keymap.set("n", "<leader>bP", function()
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	vim.notify('Copied "' .. path .. '" to the clipboard!')
end, { desc = "Copy Buffer Path (Absolute)" })

keymap.set("n", "<leader>bp", function()
	local path = vim.fn.expand("%:f")
	vim.fn.setreg("+", path)
	vim.notify('Copied "' .. path .. '" to the clipboard!')
end, { desc = "Copy Buffer Path (Relative)" })

-- Reveal buffer in finder
keymap.set("n", "<leader>br", function()
	local path = vim.api.nvim_buf_get_name(0)
	os.execute("open -R " .. path)
end, { desc = "Reveal Buffer" })

-- Delete default keymaps
-- keymap.del("n", "<c-/>")
keymap.del("n", "<leader>ft")
keymap.del("n", "<leader>fT")
