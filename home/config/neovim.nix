{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    # Nix 管理 Neovim 插件
    plugins = with pkgs.vimPlugins; [
      tokyonight-nvim
      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      nvim-treesitter
      nvim-treesitter.withAllGrammars
      lualine-nvim
    ];

    extraPackages = with pkgs; [
      ripgrep
      fd
      # LSP servers
      nixd
      clang-tools
      pyright
      nodePackages.typescript-language-server
      nodePackages.vscode-langservers-extracted
      rust-analyzer
      gopls
    ];
  };

  xdg.configFile."nvim/init.lua".text = ''
    ------------------------------------------------------------
    -- 基础
    ------------------------------------------------------------
    vim.g.mapleader = " "
    vim.o.number = true
    vim.o.relativenumber = false
    vim.o.expandtab = true
    vim.o.shiftwidth = 2
    vim.o.tabstop = 2
    vim.o.smartindent = true
    vim.o.termguicolors = true
    vim.o.signcolumn = "yes"
    vim.o.updatetime = 300
    vim.o.clipboard = "unnamedplus"
    vim.deprecate = function() end

    ------------------------------------------------------------
    -- 主题
    ------------------------------------------------------------
    vim.cmd.colorscheme("tokyonight-night")

    ------------------------------------------------------------
    -- LSP
    ------------------------------------------------------------
    local lspconfig = require("lspconfig")

    -- 统一的 on_attach（避免全局 keymap 污染）
    local on_attach = function(_, bufnr)
      local map = function(mode, lhs, rhs)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr })
      end

      map("n", "gd", vim.lsp.buf.definition)
      map("n", "gr", vim.lsp.buf.references)
      map("n", "K", vim.lsp.buf.hover)
      map("n", "<leader>rn", vim.lsp.buf.rename)
      map("n", "<leader>ca", vim.lsp.buf.code_action)
    end

    -- LSP servers
    local servers = {
      nixd = {},
      clangd = {},
      pyright = {},
      ts_ls = {},
      eslint = {},
      rust_analyzer = {},
      gopls = {},
    }

    for name, cfg in pairs(servers) do
      lspconfig[name].setup(vim.tbl_extend("force", cfg, {
        on_attach = on_attach,
      }))
    end

    vim.diagnostic.config({
      virtual_text = false,
      signs = true,
      underline = true,
      update_in_insert = false,
    })

    ------------------------------------------------------------
    -- 自动补全
    ------------------------------------------------------------
    local cmp = require("cmp")
    cmp.setup({
      mapping = {
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
      },
      sources = {
        { name = "nvim_lsp" },
      },
    })

    ------------------------------------------------------------
    -- Treesitter（仅高亮）
    ------------------------------------------------------------
    require("nvim-treesitter.configs").setup({
      highlight = {
        enable = true,
      },
    })

    ------------------------------------------------------------
    -- 状态栏
    ------------------------------------------------------------
    require("lualine").setup({
      options = {
        section_separators = "",
        component_separators = "",
      },
     })
  '';
}

