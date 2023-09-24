local nvim_tree_status_ok, nvim_tree = pcall(require, "nvim-tree")
if not nvim_tree_status_ok then
	return
end

-- empty setup using defaults
nvim_tree.setup()
