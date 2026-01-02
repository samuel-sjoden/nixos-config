{ config, pkgs, callPackage, ... }: 

{
services.xserver = {
  enable = true;
  windowManager.i3 = {
  	enable = true;
	configFile = ./i3/config;
	extraPackages = with pkgs; [
		dmenu
		i3status
	];
  };
};
services.displayManager.defaultSession = "none+i3";
  services.pulseaudio.enable = true;
  services.pipewire.enable = false;
  nixpkgs.config.pulseaudio = true;

  services.xserver.videoDrivers = [ "modesetting" ];
  hardware.graphics.enable = true;


}
