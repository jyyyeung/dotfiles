-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
	"AstroNvim/astrocommunity",
	{ import = "astrocommunity.pack.lua" },
	{ import = "astrocommunity.colorscheme.catppuccin" },
	{ import = "astrocommunity.pack.python" },
	{ import = "astrocommunity.pack.typescript" },
	{ import = "astrocommunity.pack.lua" },
	{ import = "astrocommunity.pack.java" },
	{ import = "astrocommunity.pack.json" },
	{ import = "astrocommunity.pack.yaml" },
	{ import = "astrocommunity.pack.markdown" },
	{ import = "astrocommunity.pack.docker" },
	{ import = "astrocommunity.pack.chezmoi" },
	{ import = "astrocommunity.editing-support.todo-comments-nvim" },
	-- import/override with your plugins folder
}
