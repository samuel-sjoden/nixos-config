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
	# visual
    nvim-web-devicons
	nord-nvim

    # telescope setup
    plenary-nvim
    {
      plugin = telescope-nvim;
      config = toLuaFile ./nvim/plugin/telescope.lua;
    }
    telescope-fzf-native-nvim

	# which-key setup
	which-key-nvim

	# autopairs setup
	{
	  plugin = nvim-autopairs;
	  config = toLuaFile ./nvim/plugin/autopairs.lua;
	}
	
	# treesitter setup
	(nvim-treesitter.withPlugins (p : [p.c p.python p.cmake p.cpp p.lua p.nix]))

	# autocomplete setup
	cmp-nvim-lsp
	cmp-buffer
	cmp-path
	cmp-cmdline
	{
	  plugin = nvim-cmp;
	  config = toLuaFile ./nvim/plugin/cmp.lua;
	}
	luasnip

    ];

    extraConfig = "${toLuaFile ./nvim/options.lua}";
    extraPackages = with pkgs; [
     xclip
     wl-clipboard

	 # External language servers
     pyright
	 ltex-ls
     clang-tools
    ];
  };
  
  programs.bash = {
    enable = true;
    enableCompletion = true;

    shellAliases = {
	lw = "librewolf";
	gs = "git status";
    };
  };

  
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;
}
