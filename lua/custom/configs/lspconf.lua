local base = require("plugins.configs.lspconfig")
local on_attach = base.on_attach
local capabilities = base.capabilities

local lspconfig = require("lspconfig")
local util = require("lspconfig.util")

-- C/C++ Language Server
lspconfig.clangd.setup {
  on_attach = function(client, bufnr)
    client.server_capabilities.signatureHelpProvider = false
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
  cmd = {
    "clangd",
    "--query-driver=/opt/devkitpro/devkitARM/**/arm-none-eabi*",
    "--compile-commands-dir=."
  },
  init_options = {
    clangdFileStatus = true,
  },
--  root_dir = require'lspconfig'.util.root_pattern('.git', 'compile_commands.json', 'Makefile', '.')
}

-- TypeScript Server (tsserver)
lspconfig.tsserver.setup {
  on_attach = function(client, bufnr)
    -- Custom configurations or disabling capabilities can go here
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
  root_dir = util.root_pattern("tsconfig.json", "package.json", "jsconfig.json", ".git"),
}

-- Angular Language Server (angularls)
lspconfig.angularls.setup {
  on_attach = function(client, bufnr)
    -- Custom configurations or disabling capabilities can go here
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
  root_dir = util.root_pattern("angular.json", "package.json", ".git"),
}

-- HTML Language Server (html)
lspconfig.html.setup {
  on_attach = function(client, bufnr)
    -- Custom configurations or disabling capabilities can go here
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
  root_dir = util.root_pattern("index.html", ".git", "package.json"),
}

-- CSS Language Server (cssls)
lspconfig.cssls.setup {
  on_attach = function(client, bufnr)
    -- Custom configurations or disabling capabilities can go here
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
  root_dir = util.root_pattern("style.css", ".git", "package.json"),
}

-- Lua Language Server (lua_ls) for Neovim Configuration
lspconfig.lua_ls.setup {
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" }, -- Recognize the 'vim' global
      },
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true,
        },
      },
    },
  },
}
