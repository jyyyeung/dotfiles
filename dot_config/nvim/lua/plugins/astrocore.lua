---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = function(_, opts)
    opts.options = opts.options or {}
    opts.options.opt = vim.tbl_deep_extend("force", opts.options.opt or {}, {
      clipboard = "unnamedplus",
    })

    -- Only force OSC 52 when connected via SSH (headless server)
    if vim.env.SSH_TTY then
      opts.options.g = vim.tbl_deep_extend("force", opts.options.g or {}, {
        clipboard = {
          name = "OSC 52",
          copy = {
            ["+"] = require("vim.ui.clipboard.osc52").copy "+",
            ["*"] = require("vim.ui.clipboard.osc52").copy "*",
          },
          paste = {
            ["+"] = require("vim.ui.clipboard.osc52").paste "+",
            ["*"] = require("vim.ui.clipboard.osc52").paste "*",
          },
        },
      })
    end

    return opts
  end,
}
