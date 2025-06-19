{
  description = "My dotfiles";

  nixConfig = {
    # substituers will be appended to the default substituters when fetching packages
    extra-substituters = [
      "https://anyrun.cachix.org"
    ];
    extra-trusted-public-keys = [
      "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # To get the latest version of claude code
    nixpkgs-2025-06-16.url = "github:nixos/nixpkgs/e53b1743e65c76e970612f51972b7ee87e380729";

    xremap-flake = {
      url = "github:xremap/nix-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-24.11-darwin";
    nix-darwin = {
      url = "github:LnL7/nix-darwin/nix-darwin-24.11";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
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
      pkgs-2025-06-16 = import inputs.nixpkgs-2025-06-16 {
          inherit system;
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
