local M = {}

local config = require("auto-save.config")
local autosave_on
local api = vim.api
local fn = vim.fn
local cmd = vim.cmd

api.nvim_create_augroup("AutoSave", {
	clear = true,
})

local global_vars = {}

local function set_buf_var(buf, name, value)
	if buf == nil then
		global_vars[name] = value
	else
		if api.nvim_buf_is_valid(buf) then
			api.nvim_buf_set_var(buf, "autosave_" .. name, value)
		end
	end
end

local function get_buf_var(buf, name)
	if buf == nil then
		return global_vars[name]
	end
	local success, mod = pcall(api.nvim_buf_get_var, buf, "autosave_" .. name)
	return success and mod or nil
end

local function debounce(lfn, duration)
	local function inner_debounce()
		local buf = api.nvim_get_current_buf()
		if not get_buf_var(buf, "queued") then
			vim.defer_fn(function()
				lfn(buf)
				set_buf_var(buf, "queued", false)
			end, duration)
			set_buf_var(buf, "queued", true)
		end
	end

	return inner_debounce
end

function M.save(buf)
	buf = buf or api.nvim_get_current_buf()
	if not api.nvim_buf_is_valid(buf) then
		return
	end

	if not fn.getbufvar(buf, "&modifiable") then
		return
	end

	if not api.nvim_buf_get_option(buf, "modified") then
		return
	end

	if vim.tbl_contains(config.options.ignore_filetypes, vim.api.nvim_buf_get_option(buf, "filetype")) then
		return
	end

	if vim.tbl_contains(config.options.ignore_buftypes, vim.api.nvim_buf_get_option(buf, "buftype")) then
		return
	end

	api.nvim_buf_call(buf, function()
		cmd("silent! write")
	end)
	local file_name = vim.api.nvim_buf_get_name(buf)
	print(file_name .. " saved at " .. vim.fn.strftime("%H:%M:%S"))
end

local save_func = (config.options.debounce_delay > 0 and debounce(M.save, config.options.debounce_delay) or M.save)

local function perform_save()
	save_func()
end

function M.on()
	api.nvim_create_autocmd(config.options.trigger_events, {
		callback = function()
			perform_save()
		end,
		pattern = "*",
		group = "AutoSave",
	})

	autosave_on = true
end

function M.off()
	api.nvim_create_augroup("AutoSave", {
		clear = true,
	})

	autosave_on = false
end

function M.toggle()
	if autosave_on then
		M.off()
		vim.api.nvim_notify("auto-save off", vim.log.levels.INFO, {})
	else
		M.on()
		vim.api.nvim_notify("auto-save on", vim.log.levels.INFO, {})
	end
end

function M.setup(options)
	config.options = vim.tbl_extend("keep", options, config.options)
end

return M
