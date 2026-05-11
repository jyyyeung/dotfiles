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
	{ import = "astrocommunity.media.vim-wakatime" },
	{ import = "astrocommunity.scrolling.mini-animate" },
	{ import = "astrocommunity.utility.hover-nvim" },
	{ import = "astrocommunity.icon.mini-icons" },
	-- { import = "astrocommunity.completion.avante-nvim" },
	{ import = "astrocommunity.search.nvim-spectre" },
	{ import = "astrocommunity.editing-support.ultimate-autopair-nvim" },
	-- { import = "astrocommunity.game.leetcode-nvim" },
	-- import/override with your plugins folder
}
