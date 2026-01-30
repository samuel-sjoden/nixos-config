{ pkgs, ... }:

{
  services.xserver = {
    enable = true;
    # Setup xfce for the desktop environment
    desktopManager.xfce = {
      enable = true;
      noDesktop = true;
      enableXfwm = false;
    };

    displayManager.lightdm.enable = true;
    windowManager.i3 = {
      enable = true;
      # configFile = ./i3/i3-config;
      extraPackages = with pkgs; [
        dmenu
        i3status
        rofi
        feh
        pavucontrol
        wireplumber
        pipewire
        alsa-utils
        pulseaudio
        rtkit
      ];
    };
  };
  services.displayManager.defaultSession = "xfce+i3";
  services.xserver.videoDrivers = [ "modesetting" ];
  hardware.graphics.enable = true;

}
