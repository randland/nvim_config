return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    -- local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
    -- local event = 'BufWritePre' -- or "BufWritePost"
    -- local async = event == 'BufWritePost'

    null_ls.setup({
      sources = {
        -- null_ls.builtins.formatting.rubocop,
        -- null_ls.builtins.diagnostics.rubocop,
        null_ls.builtins.formatting.prettier,
        --.with({
        --  filetypes = {
        --    "javascript",
        --    "typescript",
        --    "css",
        --    "scss",
        --    "html",
        --    "json",
        --    "yaml",
        --    "markdown",
        --    "graphql",
        --    "md",
        --    "txt",
        --  }
        --}),
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.formatting.stylua,
      },
      on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.keymap.set("n", "<leader>z", function()
            vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
          end, { buffer = bufnr, desc = "[lsp] format" })

          -- format on save
          -- vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
          -- vim.api.nvim_create_autocmd(event, {
          --   buffer = bufnr,
          --   group = group,
          --   callback = function()
          --     vim.lsp.buf.format({ bufnr = bufnr, async = async })
          --   end,
          --   desc = "[lsp] format on save",
          -- })
        end

        if client.supports_method("textDocument/rangeFormatting") then
          vim.keymap.set("x", "<Leader>z", function()
            vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
          end, { buffer = bufnr, desc = "[lsp] format" })
        end
      end,
    })

    vim.keymap.set("n", "<leader>gf", function()
      vim.lsp.buf.format()
      vim.cmd("retab")
    end, {})
  end,
}
