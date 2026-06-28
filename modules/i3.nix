{pkgs, ...}: {
  services.xserver = {
    enable = true;
    # Setup xfce for the desktop environment
    # desktopManager.xfce = {
    #   enable = true;
    #   noDesktop = true;
    #   enableXfwm = false;
    # };

    displayManager.startx.enable = true;
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        i3status
        rofi
        feh
        pavucontrol
        wireplumber
        pipewire
        alsa-utils
        pulseaudio
        rtkit
        brightnessctl
      ];
    };
  };
  services.displayManager.defaultSession = "none+i3";
  services.xserver.videoDrivers = ["modesetting"];
  hardware.graphics.enable = true;
}
