-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- Doge plugin
vim.g.doge_mapping = "<leader>D"

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

-- Navigation
keymap({ "n", "x" }, "<C-h>", "<cmd>TmuxNavigateLeft<CR>", { desc = "window left" })
keymap({ "n", "x" }, "<C-l>", "<cmd>TmuxNavigateRight<CR>", { desc = "window right" })
keymap({ "n", "x" }, "<C-j>", "<cmd>TmuxNavigateDown<CR>", { desc = "window down" })
keymap({ "n", "x" }, "<C-k>", "<cmd>TmuxNavigateUp<CR>", { desc = "window up" })

-- Resize with arrows
keymap("n", "<C-Up>", "<cmd>resize -2<CR>", opts)
keymap("n", "<C-Down>", "<cmd>resize +2<CR>", opts)
keymap("n", "<C-Left>", "<cmd>vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", "<cmd>vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", "<cmd>bnext<CR>", opts)
keymap("n", "<S-h>", "<cmd>bprevious<CR>", opts)

-- Navigate Quick list
keymap("n", "]q", "<cmd>cnext<CR>", opts)
keymap("n", "[q", "<cmd>cprevious<CR>", opts)

-- Clear highlights
keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", { silent = true, desc = "Clear Highlights" })

-- Close buffers
keymap("n", "<leader>c", "<cmd>Bdelete!<CR>", { silent = true, desc = "Close" })
keymap("n", "<leader>bo", function()
	vim.cmd.BufferLineCloseLeft()
	vim.cmd.BufferLineCloseRight()
end, { silent = true, desc = "Close others" })
keymap("n", "<leader>bl", "<cmd>BufferLineCloseRight<CR>", { silent = true, desc = "Close right" })
keymap("n", "<leader>bh", "<cmd>BufferLineCloseLeft<CR>", { silent = true, desc = "Close left" })

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Comment --
keymap("n", "<leader>/", "gcc", { desc = "Comment", remap = true })
keymap("x", "<leader>/", "gc", { desc = "Comment", remap = true })

-- NvimTree
keymap("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", opts)
-- Outline
keymap("n", "<leader>o", "<cmd>SymbolsOutline<CR>", opts)

-- Find
keymap("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { silent = true, desc = "Find files" })
keymap("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { silent = true, desc = "Find word" })
keymap("n", "<leader>fp", "<cmd>Telescope projects<CR>", { silent = true, desc = "Find projects" })
keymap("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { silent = true, desc = "Find buffers" })

-- Git
keymap("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", { silent = true, desc = "Lazy Git" })
keymap("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { silent = true, desc = "Git status" })
keymap("n", "<leader>gvo", "<cmd>DiffviewOpen<cr>", { desc = "Diffview Open" })
keymap("n", "<leader>gvc", "<cmd>DiffviewClose<cr>", { desc = "Diffview Close" })
keymap("n", "<leader>gvf", "<cmd>DiffviewFocusFiles<cr>", { desc = "Diffview Focus files" })
keymap("n", "<leader>gvh", "<cmd>DiffviewFileHistory %<cr>", { desc = "Diffview Current File history" })
keymap("n", "<leader>gvH", "<cmd>DiffviewFileHistory<cr>", { desc = "Diffview File history" })
keymap("n", "<leader>gvt", "<cmd>DiffviewToggleFiles<cr>", { desc = "Diffview Toggle files" })
keymap("n", "<leader>gvr", "<cmd>DiffviewRefresh<cr>", { desc = "Diffview Refresh" })

-- Debug
keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", { silent = true, desc = "Breakpoint" })
keymap(
	"n",
	"<Leader>dB",
	"<Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
	{ silent = true, desc = "Breakpoint condition" }
)
keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", { silent = true, desc = "Continue" })
keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", { silent = true, desc = "Step Into" })
keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", { silent = true, desc = "Step Over" })
keymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", { silent = true, desc = "Step Out" })
keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", { silent = true, desc = "REPL Toggle" })
keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", { silent = true, desc = "Run Last" })
keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", { silent = true, desc = "UI Toggle" })
keymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", { silent = true, desc = "Terminate" })
keymap("n", "<leader>dh", "<cmd>lua require'dap.ui.widgets'.hover()<CR>")
keymap(
	"n",
	"<Leader>dl",
	"<Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
	{ silent = true, desc = "Breakpoint log" }
)
keymap("n", "<Leader>dL", "<Cmd>lua require'dap'.run_last()<CR>", { silent = true, desc = "Run last" })

-- Toggle
keymap(
	"n",
	"<leader>tt",
	"<cmd>TroubleToggle document_diagnostics<cr>",
	{ silent = true, noremap = true, desc = "Toggle Trouble Doc" }
)
keymap("n", "<leader>tT", "<cmd>TroubleToggle<cr>", { silent = true, noremap = true, desc = "Toggle Trouble" })
keymap({ "n", "t" }, "<A-1>", "<cmd>ToggleTerm direction=horizontal<cr>")
keymap({ "n", "t" }, "<A-2>", "<cmd>ToggleTerm direction=vertical<cr>")
keymap({ "n", "t" }, "<A-3>", "<cmd>ToggleTerm direction=float<cr>")

-- LSP
keymap("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", { silent = true, noremap = true, desc = "Rename" })
