local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
	return
end

local dap_ui_status_ok, dapui = pcall(require, "dapui")
if not dap_ui_status_ok then
	return
end

local dap_vt_status_ok, dap_virtual_text = pcall(require, "nvim-dap-virtual-text")
if not dap_vt_status_ok then
	return
end

dap_virtual_text.setup()

dapui.setup({
	layouts = {
		{
			elements = {
				"scopes",
				"breakpoints",
				"stacks",
				"watches",
			},
			size = 40,
			position = "left",
		},
		{
			elements = {
				"repl",
				"console",
			},
			size = 10,
			position = "bottom",
		},
	},
})

vim.keymap.set("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<CR>")
vim.keymap.set("n", "<leader>dh", "<cmd>lua require'dap.ui.widgets'.hover()<CR>")

vim.keymap.set("n", "<leader>dc", "<Cmd>lua require'dap'.continue()<CR>")
vim.keymap.set("n", "<leader>do", "<Cmd>lua require'dap'.step_over()<CR>")
vim.keymap.set("n", "<leader>di", "<Cmd>lua require'dap'.step_into()<CR>")
vim.keymap.set("n", "<leader>dO", "<Cmd>lua require'dap'.step_out()<CR>")
vim.keymap.set("n", "<Leader>db", "<Cmd>lua require'dap'.toggle_breakpoint()<CR>")
vim.keymap.set("n", "<Leader>dB", "<Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
vim.keymap.set(
	"n",
	"<Leader>dlp",
	"<Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>"
)
vim.keymap.set("n", "<Leader>dr", "<Cmd>lua require'dap'.repl.open()<CR>")
vim.keymap.set("n", "<Leader>dl", "<Cmd>lua require'dap'.run_last()<CR>")

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

local dap_vscode_status_ok, dap_vscode = pcall(require, "dap-vscode-js")
if not dap_vscode_status_ok then
	return
end

dap_vscode.setup({
	-- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
	debugger_path = os.getenv("HOME") .. "/.local/share/nvim/site/pack/packer/opt/vscode-js-debug", -- Path to vscode-js-debug installation.
	adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
})

require("string")

function Scandir(directory, pattern)
	local i, t, popen = 0, {}, io.popen
	local pfile = popen('ls -a "' .. directory .. '"')
	if pfile ~= nil then
		i = i + 1
		t[i] = ""
		for filename in pfile:lines() do
			if string.match(filename, pattern) ~= nil then
				i = i + 1
				t[i] = filename
			end
		end
		pfile:close()
	end
	return t
end

function LoadEnvFile()
	return coroutine.create(function(dap_run_co)
		local cwdFiles = Scandir(vim.fn.getcwd(), "^.env")
		if next(cwdFiles) == nil then
			return coroutine.resume(dap_run_co, {})
		end
		vim.ui.select(cwdFiles, {
			prompt = "Select an env file: ",
		}, function(filename)
			local envVars = {}
			if filename ~= "" then
				local file = io.open(filename, "r")
				if file then
					for line in file:lines() do
						local k = string.match(line, "([^%s]+)=")
						local v = string.match(line, '="?([^("$)]+)')
						if k ~= nil then
							envVars[k] = v
						end
					end
				end
			end
			coroutine.resume(dap_run_co, envVars)
		end)
	end)
end

function GetArgs()
	return coroutine.create(function(dap_run_co)
		vim.ui.input({
			prompt = "Args: ",
			default = "",
		}, function(input)
			coroutine.resume(dap_run_co, input)
		end)
	end)
end

for _, language in ipairs({ "typescript", "javascript" }) do
	require("dap").configurations[language] = {
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch file",
			program = "${file}",
			cwd = "${workspaceFolder}",
			console = "integratedTerminal",
			env = LoadEnvFile(),
			args = GetArgs(),
		},
		{
			name = "Attach",
			type = "pwa-node",
			request = "attach",
			cwd = vim.fn.getcwd(),
			sourceMaps = true,
			protocol = "inspector",
			skipFiles = { "<node_internals>/**/*.js" },
		},
		{
			type = "pwa-node",
			request = "attach",
			name = "Attach to process",
			processId = require("dap.utils").pick_process,
			cwd = "${workspaceFolder}",
			console = "integratedTerminal",
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "NPM Run",
			runtimeExecutable = "npm",
			runtimeArgs = {
				"run",
				function()
					return coroutine.create(function(dap_run_co)
						vim.ui.input({
							prompt = "Name of the script: ",
							default = "",
						}, function(scriptName)
							coroutine.resume(dap_run_co, scriptName)
						end)
					end)
				end,
			},
			rootPath = "${workspaceFolder}$",
			cwd = "${workspaceFolder}",
			console = "integratedTerminal",
			env = LoadEnvFile(),
		},
	}
end
