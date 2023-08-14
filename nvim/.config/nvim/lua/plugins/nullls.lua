return {
  "jose-elias-alvarez/null-ls.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local null_ls = require("null-ls")

    local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
    local event = "BufWritePre" -- or "BufWritePost"
    local async = event == "BufWritePost"

    local check_eslint_config = function(utils)
      return utils.root_has_file({ ".eslintrc", ".eslintrc.js", ".eslintrc.cjs" })
    end

    local check_prettier_config = function(utils)
      return utils.root_has_file({ ".prettierrc", ".prettierrc.js", ".prettierrc.cjs", ".prettier.config.js" })
    end

    local sources = {
      null_ls.builtins.formatting.prettier.with({
        condition = check_prettier_config,
      }),
      null_ls.builtins.formatting.eslint_d.with({
        condition = check_eslint_config
      }),
      null_ls.builtins.formatting.stylua, }

    null_ls.setup({
      sources = sources,
      debug = true,
      on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.keymap.set("n", "<Leader>f", function()
            vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
          end, { buffer = bufnr, desc = "[lsp] format" })

          -- format on save
          vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
          vim.api.nvim_create_autocmd(event, {
            buffer = bufnr,
            group = group,
            callback = function()
              vim.lsp.buf.format({ bufnr = bufnr, async = async })
            end,
            desc = "[lsp] format on save",
          })
        end

        if client.supports_method("textDocument/rangeFormatting") then
          vim.keymap.set("x", "<Leader>f", function()
            vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
          end, { buffer = bufnr, desc = "[lsp] format" })
        end
      end,
    })
  end,
}
