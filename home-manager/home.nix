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

	# i3 packages
	dmenu
	i3status
	rofi
	feh
	dunst
	i3lock-color
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
	rebuild = "sudo nixos-rebuild switch --flake /home/samuel/nixos-config#hostname";
    };
  };
  
  xdg.dataFile."rofi/themes".source = "${rofiThemes}/themes";
  programs.rofi = {
  	enable = true;
	theme = "nord";
  };


	xdg.configFile."i3/config" = {
	  source = ./i3/config/i3-config;
	  force = true;
	};

	xdg.configFile."dunst/dunstrc".source = ./i3/dunst/dunstrc;
 	xdg.configFile."i3status/config".source = ./i3/i3status/config; 

# programs.i3status = {
#   enable = true;
#   enableDefault = false;
#
#   general = {
#     colors = true;
#     interval = 1;
#     color_good = "#bfbaac";
#     color_degraded = "#d12f2c";
#     color_bad = "#d12f2c";
#   };
#
#   modules = {
#     "load" = {
#       position = 1;
#       settings = {
#         format = "  %5min";
#       };
#     };
#
#     # "cpu_temperature 0" = {
#     #   position = 2;
#     #   settings = {
#     #     format = "  %degrees°C";
#     #     path = "/sys/class/thermal/thermal_zone0/temp";
#     #   };
#     # };
#
#     "wireless wlp2s0" = {
#       position = 3;
#       settings = {
#         format_up = "  %essid";
#         format_down = "  Disconnected";
#       };
#     };
#
#     "volume master" = {
#     position = 1;
#     settings = {
#       format = "♪ %volume";
#       format_muted = "♪ muted (%volume)";
#       device = "pulse:1";
#     };
# 	};
#
#     "battery 0" = {
#       position = 5;
#       settings = {
#         last_full_capacity = true;
#         format = "%status %percentage";
#         format_down = "No Battery";
#         status_chr = "";
#         status_bat = "";
#         status_unk = "";
#         status_full = "";
#         path = "/sys/class/power_supply/BAT%d/uevent";
#         low_threshold = 10;
#         integer_battery_capacity = true;
#       };
#     };
#
#     "time" = {
#       position = 6;
#       settings = {
#         format = "  %b %d %H:%M";
#       };
#     };
#   };
# };
  home.stateVersion = "25.05";
}
