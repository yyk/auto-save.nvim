vim.api.nvim_create_user_command("AutoSaveToggle", function()
	require("auto-save").toggle()
end, {})

if require("auto-save.config").options.enabled then
	require("auto-save").on()
end
