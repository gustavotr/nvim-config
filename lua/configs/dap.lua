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
	debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug", -- Path to vscode-js-debug installation.
	adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
})

for _, language in ipairs({ "typescript", "javascript" }) do
	require("dap").configurations[language] = {
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch file",
			program = "${file}",
			cwd = "${workspaceFolder}",
			skipFiles = { "<node_internals>/**", "**/node_modules/**" },
		},
		{
			name = "Attach",
			type = "pwa-node",
			request = "attach",
			cwd = "${workspaceFolder}",
			sourceMaps = true,
			protocol = "inspector",
			skipFiles = { "<node_internals>/**", "**/node_modules/**" },
		},
		{
			type = "pwa-node",
			request = "attach",
			name = "Attach to process",
			processId = require("dap.utils").pick_process,
			cwd = "${workspaceFolder}",
			skipFiles = { "<node_internals>/**", "**/node_modules/**" },
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "Debug Jest Tests",
			-- trace = true, -- include debugger info
			runtimeExecutable = "node",
			runtimeArgs = {
				"./node_modules/jest/bin/jest.js",
				"--runInBand",
			},
			rootPath = "${workspaceFolder}",
			cwd = "${workspaceFolder}",
			console = "integratedTerminal",
			internalConsoleOptions = "neverOpen",
			skipFiles = { "<node_internals>/**", "**/node_modules/**" },
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
			skipFiles = { "<node_internals>/**", "**/node_modules/**" },
		},
	}
end

for _, language in ipairs({ "typescriptreact", "javascriptreact" }) do
	require("dap").configurations[language] = {
		{
			name = "Attach",
			type = "pwa-node",
			request = "attach",
			cwd = vim.fn.getcwd(),
			sourceMaps = true,
			protocol = "inspector",
			skipFiles = { "<node_internals>/**", "**/node_modules/**" },
		},
		{
			type = "pwa-chrome",
			name = "Attach - Remote Debugging",
			request = "attach",
			program = "${file}",
			cwd = vim.fn.getcwd(),
			sourceMaps = true,
			protocol = "inspector",
			port = 9222,
			webRoot = "${workspaceFolder}",
			skipFiles = { "<node_internals>/**", "**/node_modules/**" },
		},
		{
			type = "pwa-chrome",
			name = "Launch Chrome",
			request = "launch",
			url = "http://localhost:3000",
			skipFiles = { "<node_internals>/**", "**/node_modules/**" },
		},
	}
end
