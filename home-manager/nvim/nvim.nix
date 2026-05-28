{pkgs, ...}: {
  home.packages = with pkgs; [
    ripgrep
    fzf
    # Alternative to find
    fd
  ];
  programs.neovim = let
    # toLua = str: "lua << EOF\n${str}\nEOF\n";
    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
  in {
    enable = true;
    defaultEditor = true;

    plugins = with pkgs.vimPlugins; [
      # visual
      nvim-web-devicons
      tender-vim
      kanagawa-paper-nvim

      # telescope setup
      plenary-nvim
      {
        plugin = telescope-nvim;
        config = toLuaFile ./plugin/telescope.lua;
      }
      telescope-fzf-native-nvim

      # neo tree setup
      nui-nvim
      snacks-nvim # image viewing
      {
        plugin = neo-tree-nvim;
        config = toLuaFile ./plugin/neo-tree.lua;
      }

      # which-key setup
      which-key-nvim

      # autopairs setup
      {
        plugin = nvim-autopairs;
        config = toLuaFile ./plugin/autopairs.lua;
      }

      # treesitter setup
      (nvim-treesitter.withPlugins (p: [
        p.c
        p.python
        p.cmake
        p.cpp
        p.lua
        p.nix
        p.vhdl
        p.asm
      ]))

      # autocomplete setup
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-cmdline
      {
        plugin = nvim-cmp;
        config = toLuaFile ./plugin/cmp.lua;
      }

      luasnip
      {
        plugin = conform-nvim;
        config = toLuaFile ./plugin/conform.lua;
      }
      {
        plugin = indent-blankline-nvim;
        config = toLuaFile ./plugin/indent-blankline.lua;
      }

      vim-clang-format
    ];

    extraConfig = "${toLuaFile ./options.lua}";
    extraPackages = with pkgs; [
      xclip
      wl-clipboard
      tree-sitter

      # External language servers
      pyright
      ltex-ls
      clang-tools
      nil
      vhdl-ls
      lua-language-server
      asm-lsp

      # formatters
      alejandra
      stylua
      black
      asmfmt
    ];
  };
}
