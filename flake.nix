{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    # use "nixos", or your hostname as the name of the configuration
    nixosConfigurations = {
      hostname = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};

      modules = [
        ./hosts/cyborg
		home-manager.nixosModules.home-manager
		{
      		home-manager.useGlobalPkgs = true;
			home-manager.useUserPackages = true;
			home-manager.users.samuel = ./home-manager/home.nix;
		}
      ];
      };
    };
  };
}
