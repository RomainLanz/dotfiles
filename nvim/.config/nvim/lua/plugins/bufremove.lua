return {
  "echasnovski/mini.bufremove",
  version = false,
  main = "mini.bufremove",
  keys = {
    { "<leader>td", "<CMD>:lua MiniBufremove.delete()<CR>", desc = "Delete buffer" },
  },
  config = true,
}
