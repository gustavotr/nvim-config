local colorscheme = "tokyonight"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	return
end

local transparency_status_ok, transparent = pcall(require, "transparent")
if not status_ok then
	return
end

transparent.setup({
	enable = true,
})
