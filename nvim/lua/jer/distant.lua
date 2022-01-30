local distant_status_ok, distant = pcall(require, "distant")
if not distant_status_ok then
	return
end

distant.setup({
	["*"] = require("distant.settings").chip_default(),
})
