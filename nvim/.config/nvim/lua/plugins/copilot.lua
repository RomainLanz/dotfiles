return {
  "github/copilot.vim",
  keys = {
    { "<C-J>", 'copilot#Accept("<CR>")', mode = "i", desc = "Accept Copilot suggestion", expr = true, silent = true, noremap = true, replace_keycodes = false },
  },
  lazy = false,
  config = function()
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_filetypes = {
      ["*"] = false,
      ["javascript"] = true,
      ["javascriptreact"] = true,
      ["typescriptreact"] = true,
      ["json"] = true,
      ["rust"] = true,
      ["c"] = true,
      ["c#"] = true,
      ["c++"] = true,
      ["go"] = true,
      ["python"] = true,
      ["vue"] = true,
    }
  end,
}
