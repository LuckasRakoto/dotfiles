return {
  "folke/tokyonight.nvim",
  config = function()
    require("tokyonight").setup({
      style = "storm",
      transparent = false,
      terminal_colors = false,
    })

    -- Set the colorscheme
    vim.cmd("colorscheme tokyonight")
  end
}
