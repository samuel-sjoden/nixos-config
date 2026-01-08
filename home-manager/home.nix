{config, pkgs, ...}:

{
  home.username = "samuel";
  home.homeDirectory = "/home/samuel";

  imports = [
	./nvim/nvim.nix
	./i3/i3.nix
  ];

  home.packages = with pkgs; [
    neofetch
    tree
    btop
    librewolf
	discord
	alacritty
	syncthing
	obsidian
  ];

  
  programs.alacritty = {
  	enable = true;
	theme = "hatsunemiku";
	settings = {
		window = {
			decorations = "None";
		};
		font = {
			normal.family = "DroidSansM Nerd Font Mono";
			normal.style = "Regular";
			bold.family = "DroidSansM Nerd Font Mono";
			italic.family = "DroidSansM Nerd Font Mono";
			bold_italic.family = "DroidSansM Nerd Font Mono";
			bold_italic.style = "Thin";
			size = 11.5;
		};
	};
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;

    shellAliases = {
	lw = "librewolf";
	gs = "git status";
	ga = "git add *";
	gc = "git commit -am";
	vi = "nvim";
	rebuild = "sudo nixos-rebuild switch --flake /home/samuel/nixos-config#hostname";
    };
  };
  
  home.stateVersion = "25.05";
}
