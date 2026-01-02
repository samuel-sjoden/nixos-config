{config, pkgs, ...}:
let
	rofiThemes = pkgs.fetchFromGitHub {
		owner = "newmanls";
		repo = "rofi-themes-collection";
		rev = "master";
		sha256 = "sha256-96wSyOp++1nXomnl8rbX5vMzaqRhTi/N7FUq6y0ukS8=";
};
in

{
  home.username = "samuel";
  home.homeDirectory = "/home/samuel";

  home.packages = with pkgs; [
    neofetch
    ripgrep
    fzf
    tree
    btop
    librewolf
	discord
    # Alternative to find
    fd
	alacritty
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
  
  programs.alacritty = {
  	enable = true;
	theme = "hatsunemiku";
	settings = {
		window = {
			decorations = "None";
		};
	};
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;

    shellAliases = {
	lw = "librewolf";
	gs = "git status";
	vi = "nvim";
	rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#hostname";
    };
  };
  
  xdg.dataFile."rofi/themes".source = "${rofiThemes}/themes";
  programs.rofi = {
  	enable = true;
	theme = "nord";
  };
  
  home.stateVersion = "25.05";
}
