{
  description = "My dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-23.11";
    xremap-flake.url = "github:xremap/nix-flake";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations = {
      # Personal laptop
      my-nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.key5n = import ./home.nix;
          }
        ];
        specialArgs = {
          inherit (inputs) xremap-flake;
        };
      };
    };

    # homeConfigurations = {
    #   key5n = nixpkgs.lib.homeManagerConfiguration {
    #     modules = [ ./home.nix ];
    #     pkgs = import nixpkgs { 
    #       system = "x86_64-linux";
    #     };
    #     # extraSpecialArgs = { inherit inputs outputs; };
    #   };
    # };
  };
}