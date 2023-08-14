return {
  "jose-elias-alvarez/null-ls.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local null_ls = require("null-ls")

    local check_eslint_config = function(utils)
      return utils.root_has_file({ ".eslintrc", ".eslintrc.js" })
    end

    local check_prettier_config = function(utils)
      return utils.root_has_file({ ".prettierrc" })
    end

    local sources = {
      null_ls.builtins.formatting.prettier.with({
        condition = check_prettier_config,
      }),
      null_ls.builtins.formatting.eslint_d.with({
        condition = check_eslint_config
      }),
      null_ls.builtins.formatting.stylua, }

    null_ls.setup({ sources = sources, debug = true })
  end,
}
