return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    -- import mason
    -- import mason
    local mason = require("mason")

    -- import mason-lspconfig
    local mason_lspconfig = require("mason-lspconfig")

    require("go").setup({
      lsp_cfg = false,
      -- other setups...
    })
    local cfg = require("go.lsp").config() -- config() return the go.nvim gopls setup

    require("lspconfig").gopls.setup(cfg)

    -- import mason-tool-installer
    local mason_tool_installer = require("mason-tool-installer")

    -- import lspconfig
    local lspconfig = require("lspconfig")
    -- enable mason and configure icons
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    mason_lspconfig.setup({
      -- list of servers for mason to install
      ensure_installed = {
        "eslint",
        "astro",
        "html",
        "cssls",
        "tailwindcss",
        "svelte",
        "lua_ls",
        "graphql",
        "emmet_ls",
      },
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "prettier", -- prettier formatter
        "stylua", -- lua formatter
        "eslint_d",
      },
    })
    --
    -- mason_lspconfig.setup_handlers({
    --   -- default handler for installed servers
    --   function(server_name)
    --     lspconfig[server_name].setup({
    --       capabilities = capabilities,
    --     })
    --   end,
    --   --     ["svelte"] = function()
    --   --       -- configure svelte server
    --   --       lspconfig["svelte"].setup({
    --   --         capabilities = capabilities,
    --   --         on_attach = function(client, bufnr)
    --   --           vim.api.nvim_create_autocmd("BufWritePost", {
    --   --             pattern = { "*.js", "*.ts" },
    --   --             callback = function(ctx)
    --   --               -- Here use ctx.match instead of ctx.file
    --   --               client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
    --   --             end,
    --   --           })
    --   --         end,
    --   --       })
    --   --     end,
    --   --     ["graphql"] = function()
    --   --       -- configure graphql language server
    --   --       lspconfig["graphql"].setup({
    --   --         capabilities = capabilities,
    --   --         filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
    --   --       })
    --   --     end,
    --   ["emmet_ls"] = function()
    --     -- configure emmet language server
    --     lspconfig["emmet_ls"].setup({
    --       capabilities = capabilities,
    --       filetypes = {
    --         "html",
    --         "typescriptreact",
    --         "javascriptreact",
    --         "css",
    --         "sass",
    --         "scss",
    --         "less",
    --         "svelte",
    --         "astro",
    --       },
    --     })
    --   end,
    --   --     ["lua_ls"] = function()
    --   --       -- configure lua server (with special settings)
    --   --       lspconfig["lua_ls"].setup({
    --   --         capabilities = capabilities,
    --   --         settings = {
    --   --           Lua = {
    --   --             -- make the language server recognize "vim" global
    --   --             diagnostics = {
    --   --               globals = { "vim" },
    --   --             },
    --   --             completion = {
    --   --               callSnippet = "Replace",
    --   --             },
    --   --           },
    --   --         },
    --   --       })
    --   --     end,
    -- })
  end,
}
