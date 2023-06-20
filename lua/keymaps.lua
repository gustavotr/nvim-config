-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Save files
keymap({ "n", "i", "v" }, "<C-s>", "<cmd>update<CR>", opts)

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Clear highlights
keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", { silent = true, desc = "Clear Highlights" })

-- Close buffers
keymap("n", "<leader>c", "<cmd>Bdelete!<CR>", { silent = true, desc = "Close" })
keymap("n", "<leader>bo", ":%bd|e#<CR>", { silent = true, desc = "Close others" })

-- Better paste
keymap("v", "p", '"_dP', opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Comment --
keymap("n", "<leader>/", "gcc", { desc = "Comment", remap = true })
keymap("x", "<leader>/", "gc", { desc = "Comment", remap = true })

-- NvimTree
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- Find
keymap("n", "<leader>ff", ":Telescope find_files<CR>", { silent = true, desc = "Find files" })
keymap("n", "<leader>fw", ":Telescope live_grep<CR>", { silent = true, desc = "Find word" })
keymap("n", "<leader>fp", ":Telescope projects<CR>", { silent = true, desc = "Find projects" })
keymap("n", "<leader>fb", ":Telescope buffers<CR>", { silent = true, desc = "Find buffers" })

-- Git
keymap("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", { silent = true, desc = "Lazy Git" })
keymap("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { silent = true, desc = "Git status" })

-- Debug
keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", { silent = true, desc = "Breakpoint" })
keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", { silent = true, desc = "Continue" })
keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", { silent = true, desc = "Step Into" })
keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", { silent = true, desc = "Step Over" })
keymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", { silent = true, desc = "Step Out" })
keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", { silent = true, desc = "REPL Toggle" })
keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", { silent = true, desc = "Run Last" })
keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", { silent = true, desc = "UI Toggle" })
keymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", { silent = true, desc = "Terminate" })

-- Toggle
keymap("n", "<leader>tt", "<cmd>TroubleToggle<cr>", { silent = true, noremap = true, desc = "Toggle Trouble" })
