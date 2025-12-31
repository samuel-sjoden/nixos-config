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
    # Alternative to find
    fd

  ];

  programs.neovim = 
  let 
   toLua = str: "lua << EOF\n${str}\nEOF\n";
   toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
  in
  {
    enable = true;
    defaultEditor = true;

    plugins = with pkgs.vimPlugins; [
    # telescope lsp which-key

    # telescope setup
    plenary-nvim
    nvim-web-devicons
    telescope-fzf-native-nvim
    telescope-nvim

    ];

    extraConfig = "${toLuaFile ./nvim/options.lua}";
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

  
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;
}
