{
  self,
  nixpkgs,
  nixpkgs-unstable,
  nix-darwin,
  home-manager,
  systems,
  treefmt-nix,
  ...
}@inputs:
let
  # Small tool to iterate over each systems
  eachSystem = f: nixpkgs.lib.genAttrs (import systems) (system: f nixpkgs.legacyPackages.${system});

  # Eval the treefmt modules from ./treefmt.nix
  treefmtEval = eachSystem (pkgs: treefmt-nix.lib.evalModule pkgs ./treefmt.nix);

  genSpecialArgs =
    system:
    inputs
    // {
      pkgs-unstable = import inputs.nixpkgs-unstable {
        inherit system;
        # To use claude code, we need to allow the installation of non-free software
        config.allowUnfree = true;
      };
    };
in
{
  # for `nix fmt`
  formatter = eachSystem (pkgs: treefmtEval.${pkgs.system}.config.build.wrapper);
  # for `nix flake check`
  checks = eachSystem (pkgs: {
    formatting = treefmtEval.${pkgs.system}.config.build.check self;
  });

  nixosConfigurations =
    let
      system = "x86_64-linux";
      user-name = "key5n";
    in
    {
      nixos-desktop = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/nixos-desktop/default.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = genSpecialArgs system // {
              inherit user-name;
            };
            home-manager.users.${user-name} = import ./homes/nixos-desktop/default.nix;
          }
        ];
        specialArgs = genSpecialArgs system // {
          inherit user-name;
        };
      };

      nixos-subdesktop = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/nixos-subdesktop/default.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = inputs // {
              inherit user-name;
            };
            home-manager.users.${user-name} = import ./homes/nixos-subdesktop/default.nix;
          }
        ];
        specialArgs = genSpecialArgs system // {
          inherit user-name;
        };
      };

      nixos-wsl = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/nixos-wsl/default.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = genSpecialArgs system // {
              inherit user-name;
            };
            home-manager.users.${user-name} = import ./homes/nixos-wsl/default.nix;
          }
        ];
        specialArgs = genSpecialArgs system // {
          inherit user-name;
        };
      };

      nixos-lab = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/nixos-lab/default.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = genSpecialArgs system // {
              inherit user-name;
            };
            home-manager.users.${user-name} = import ./homes/nixos-lab/default.nix;
          }
        ];
        specialArgs = genSpecialArgs system // {
          inherit user-name;
        };
      };
    };

  darwinConfigurations =
    let
      user-name = "key5n";
      host-name = "Key5n-MacBook-Pro";
      system = "aarch64-darwin";
    in
    {
      ${host-name} = nix-darwin.lib.darwinSystem {
        inherit system;
        modules = [
          ./hosts/Key5n-MacBook-Pro/default.nix
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = genSpecialArgs system // {
              inherit user-name;
            };
            home-manager.users."${user-name}" = import ./homes/Key5n-MacBook-Pro/default.nix;
          }
        ];
        specialArgs = genSpecialArgs system // {
          inherit user-name host-name;
        };
      };
    };
}
