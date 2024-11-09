-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = { "html", "cssls", "marksman", "pyright" }
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }

-- start clangd ===============================================================
local clangd_bin = vim.fn.resolve(vim.fn.stdpath "data" .. "/mason/bin/clangd")

lspconfig.clangd.setup {
  cmd = { clangd_bin, "--offset-encoding=utf-16" },
  capabilities = nvlsp.capabilities,
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  single_file_support = true,
}
-- end clangd ================================================================

-- start gdscript ============================================================================
local localhost = "127.0.0.1"
local port = os.getenv "GDScript_Port" or "6005"
local pipe = localhost .. ":" .. "55432"

-- [OPTIONAL]
-- If you need to double-click script to open nvim
--
-- To start the server, change in godot editor settings: General > Text Editor > External
-- Use External Editor: true
-- Exec Path: <path_to_nvim>
-- Exec Flags: --server 127.0.0.1:55432 --remote-send "<C-\><C-N>:n {file}<CR>:call cursor({line},{col})<CR>"

local cmd
if vim.loop.os_uname().sysname == "Windows_NT" then
  -- https://github.com/godotengine/godot/issues/64406#issuecomment-1435395571

  -- Needs a program called nmap that provides ncat
  -- scoop install main/nmap
  cmd = "ncat"
else
  cmd = "nc"
end

lspconfig.gdscript.setup {
  capabilities = nvlsp.capabilities,
  cmd = { cmd, "127.0.0.1", port },
  filetypes = { "gd", "gdscript", "gdscript3" },
  flags = {
    debounce_text_changes = 150,
  },
  on_attach = function(client, bufnr)
    nvlsp.on_attach(client, bufnr)
    vim.opt.tabstop = 2
    vim.opt.softtabstop = 2
    vim.opt.expandtab = false

    -- This is to substitute starting the nvim with --listen argument
    vim.api.nvim_command("echo serverstart('" .. pipe .. "')")
  end,
  root_dir = lspconfig.util.root_pattern("project.godot", ".git"),
  on_init = nvlsp.on_init,
}
-- end gdscript =====================================================================================

-- start omnisharp-mono =============================================================================
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#omnisharp
-- > By default, omnisharp-roslyn doesn't have a cmd set. This is because nvim-lspconfig does not make assumptions about your path. You must add the following to your init.vim or init.lua to set cmd to the absolute path ($HOME and ~ are not expanded) of the unzipped run script or binary.

-- This omnisharp is mono version, setup to work with Unity game engine
-- Might want to consider using mason-lspconfig.nvim
-- if both mono and dotnet version are required.
local omnisharp_bin = vim.fn.resolve(vim.fn.stdpath "data" .. "/mason/bin/omnisharp-mono")

lspconfig.omnisharp.setup {
  cmd = { omnisharp_bin },
  capabilities = nvlsp.capabilities,
  filetypes = { "cs", "vb" },
  flags = {
    debounce_text_changes = 150,
  },
  on_attach = function(client, bufnr)
    nvlsp.on_attach(client, bufnr)
    vim.opt.shiftwidth = 4
    -- require "treesitter-context"
  end,
  on_init = nvlsp.on_init,
  root_dir = lspconfig.util.root_pattern("*.sln", "*.csproj"),
}
-- end omnisharp-mono ================================================================================

local diagnostic_config = {
  virtual_text = false,
  update_in_insert = true,
  float = {
    border = "rounded",
    source = "always",
  },
}
vim.diagnostic.config(diagnostic_config)
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
