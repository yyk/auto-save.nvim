local M = {
	options = {
		enabled = true, -- start auto-save when the plugin is loaded (i.e. when your package manager loads it)
		trigger_events = { "InsertLeave", "BufHidden" }, -- vim events that trigger auto-save. See :h events
		ignore_filetypes = {}, -- file types to disable auto save
		ignore_buftypes = {}, -- buf types to disable auto save
		debounce_delay = 500, -- saves the file at most every `debounce_delay` milliseconds
	},
}

return M
