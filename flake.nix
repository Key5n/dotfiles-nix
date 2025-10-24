{
  description = "My dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    xremap-flake = {
      url = "github:xremap/nix-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix.url = "github:ryantm/agenix";

    my-secrets = {
      url = "git+ssh://git@github.com/Key5n/nix-secrets.git?shallow=1";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, nix-darwin, home-manager, ... }@inputs:
  let
    genSpecialArgs = system: inputs // {
      pkgs-unstable = import inputs.nixpkgs-unstable {
          inherit system;
          # To use claude code, we need to allow the installation of non-free software
          config.allowUnfree = true;
      };
    };
  in {
    nixosConfigurations = let system = "x86_64-linux"; in {
      nixos-desktop = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/nixos-desktop/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = genSpecialArgs system;
            home-manager.users.key5n = import ./home/linux/home.nix;
          }
        ];
        specialArgs = genSpecialArgs system;
      };

      nixos-subdesktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/nixos-subdesktop/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = inputs;
            home-manager.users.key5n = import ./home/linux/home.nix;
          }
        ];
        specialArgs = inputs;
      };
    };

    darwinConfigurations = let
      userName = "key5n";
      hostName = "Key5n-MacBook-Pro";
      system = "aarch64-darwin";
      in {
      ${hostName} = nix-darwin.lib.darwinSystem {
        inherit system;
        modules = [
          ./hosts/darwin-macbook/configuration.nix
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = genSpecialArgs system;
            home-manager.users."${userName}" = import ./home/darwin/home.nix;
          }
        ];
        specialArgs = genSpecialArgs system // { inherit userName hostName; };
      };

    };
  };
}
