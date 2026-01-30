{ config, pkgs, ... }:
let
  rofiThemes = pkgs.fetchFromGitHub {
    owner = "newmanls";
    repo = "rofi-themes-collection";
    rev = "master";
    sha256 = "sha256-96wSyOp++1nXomnl8rbX5vMzaqRhTi/N7FUq6y0ukS8=";
  };
in
{

  home.packages = with pkgs; [
    # i3 packages
    dmenu
    i3status
    rofi
    feh
    dunst
    i3lock-color
  ];

  xdg.dataFile."rofi/themes".source = "${rofiThemes}/themes";
  programs.rofi = {
    enable = true;
    theme = "nord";
  };

  xdg.configFile."i3/config" = {
    source = ./config/i3-config;
    force = true;
  };

  xdg.configFile."dunst/dunstrc".source = ./dunst/dunstrc;
  xdg.configFile."i3status/config".source = ./i3status/config;

}
