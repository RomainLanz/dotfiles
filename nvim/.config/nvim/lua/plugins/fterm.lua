return {
  "numToStr/FTerm.nvim",
  keys = {
    { "<leader>t", '<CMD>lua require("FTerm").toggle()<CR>', desc = "Toggle terminal" },
    { "<ESC><ESC>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', mode = "t", desc = "Toggle terminal" },
  },
}
