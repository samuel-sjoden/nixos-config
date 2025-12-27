{config, pkgs, ...}:

{
  home.username = "samuel";
  home.homeDirectory = "/home/samuel";

  xfconf.settings = {
    xfce4-keyboard-shortcuts = {
      "commands/custom/<Super>a" = "alacritty";
      "xfwm4/custom/<Super>Up" = "maximize_window_key"; 
    };
  };


  home.packages = with pkgs; [
    neofetch
    ripgrep
    fzf
    tree
    btop

    librewolf
  ];

  programs.neovim = 
  let 
   toLua = str: "lua << EOF\n${str}\nEOF\n";
   toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
  in
  {
    enable = true;

    plugins = with pkgs.vimPlugins; [
      {
	plugin = nvim-lspconfig;
	config = toLuaFile ./nvim/plugin/lsp.lua;
      }
      {
	plugin = nvim-treesitter.withAllGrammars;
	config = toLuaFile ./nvim/plugin/treesitter.lua;
      }
      {
      	plugin = nvim-cmp;
	config = toLuaFile ./nvim/plugin/cmp.lua;
      }
      {
	plugin = telescope-nvim;
	config = toLuaFile ./nvim/plugin/telescope.lua;
      }
      {
	plugin = nvim-autopairs;
	config = toLuaFile ./nvim/plugin/autopairs.lua;
      }
      cmp-nvim-lsp
      neodev-nvim
      luasnip
      telescope-fzf-native-nvim
      comment-nvim
      todo-comments-nvim
      which-key-nvim
      nvim-web-devicons
      comfy-line-numbers-nvim
    ];

    extraConfig = "${toLuaFile ./nvim/options.lua}${toLuaFile ./nvim/remaps.lua}";
    extraPackages = with pkgs; [
     xclip
     wl-clipboard

     pyright
    ];
  };
  
  programs.bash = {
    enable = true;
    enableCompletion = true;

    shellAliases = {
	lw = "librewolf";
    };
  };

  programs.defaultBrowser = "librewolf";
  
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;
}
