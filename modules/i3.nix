{ config, pkgs, callPackage, ... }: 

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
	services.pulseaudio.enable = false;
    security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
        wireplumber.enable = true;
		# If you want to use JACK applications, uncomment this
		jack.enable = true;
		# use the example session manager (no others are packaged yet so this is enabled by default,
		# no need to redefine it in your config for now)
		#media-session.enable = true;
	};

	services.xserver.videoDrivers = [ "modesetting" ];
	hardware.graphics.enable = true;

}
