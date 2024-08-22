local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require("null-ls")

local opts = {
  sources = {
    -- clang_format for C/C++ formatting
    null_ls.builtins.formatting.clang_format,

    -- prettier for javascript, typescript, html, css, and json formatting
    null_ls.builtins.formatting.prettier.with({
      filetypes = { "javascript", "typescript", "html", "css", "json" },
    }),

    -- eslint for diagnostics and code actions
    null_ls.builtins.diagnostics.eslint_d.with({
      condition = function(utils)
        return utils.root_has_file({ ".eslintrc.js", ".eslintrc.cjs" })
      end,
    }),
    null_ls.builtins.code_actions.eslint_d,
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({
        group = augroup,
        buffer = bufnr,
      })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({
            bufnr = bufnr,
            filter = function(c)
              -- only use null-ls for formatting, not other LSPs
              return c.name == "null-ls"
            end,
          })
        end,
      })
    end
  end,
}

return opts
