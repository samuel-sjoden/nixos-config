{
 config,
 pkgs,
 lib,
 ...
} :
{
  # Define a user account. 
  users.users.samuel = {
    isNormalUser = true;
    description = "samuel sjoden";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ ];
	# TODO: Add a default shell for the user
  };

  # Fonts
  fonts.packages = with pkgs; [
	  nerd-fonts.fira-code
	  nerd-fonts.droid-sans-mono
  ];


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    neovim
    vscode
    wget
	curl
	lshw
	zip
	unzip
	tree
	vlc
	nomacs
  ];

  # Set your time zone.
  time.timeZone = "America/Vancouver";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";


}
