return {
	"yetone/avante.nvim",
	-- Avante needs its native template library built after install/update.
	build = vim.fn.has("win32") ~= 0
			and "powershell -NoProfile -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
		or "make",
	event = "VeryLazy",
	version = false,
	dependencies = {
		{ "ColinKennedy/mega.cmdparse", dependencies = { "ColinKennedy/mega.logging" } },
	},
	---@module 'avante'
	---@type avante.Config
	opts = {
		provider = "codex-cli",
		acp_providers = {
			["codex-cli"] = {
				command = vim.fn.has("win32") ~= 0 and "codex-acp.CMD" or "codex-acp",
			},
		},
	},
}
