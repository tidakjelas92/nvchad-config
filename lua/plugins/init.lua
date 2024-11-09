return {
  {
    "stevearc/conform.nvim",
    event = { "LspAttach" },
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- lua
        "lua-language-server",
        "stylua",

        -- c/cpp
        "clangd",
        "clang-format",

        -- csharp-unity
        "omnisharp-mono",

        -- godot
        "gdtoolkit",

        -- python
        "black",
        "pyright",

        -- markdown
        "marksman",
        "prettierd",

        -- shell
        "shfmt",
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",

        "html",
        "css",
        "javascript",
        "json",

        "bash",
        "c_sharp",
        "cpp",
        "gdscript",
        "godot_resource",

        "glsl",
        "hlsl",

        "markdown",
        "yaml",
      },
    },
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      renderer = {
        highlight_git = true,
        icons = {
          show = {
            git = true,
          },
          glyphs = {
            git = {
              unstaged = "",
              untracked = "U",
            },
          },
        },
      },
    },
  },

  {
    "mfussenegger/nvim-lint",
    event = { "LspAttach" },
    config = function()
      require "configs.nvim-lint"
    end,
  },

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { "LspAttach" },
  },
}
