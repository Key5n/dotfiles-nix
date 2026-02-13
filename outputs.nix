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
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        # To use claude code, we need to allow the installation of non-free software
        config.allowUnfree = true;
      };
    };

  mkHomeManagerModule =
    {
      system,
      userName,
      homePath,
    }:
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.extraSpecialArgs = genSpecialArgs system // {
        user-name = userName;
      };
      home-manager.users.${userName} = import homePath;
    };

  mkNixosConfig =
    {
      system,
      userName,
      hostPath,
      homePath,
    }:
    nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        hostPath
        home-manager.nixosModules.home-manager
        (mkHomeManagerModule {
          inherit system homePath;
          userName = userName;
        })
      ];
      specialArgs = genSpecialArgs system // {
        user-name = userName;
      };
    };

  mkDarwinConfig =
    {
      system,
      userName,
      hostName,
      hostPath,
      homePath,
    }:
    nix-darwin.lib.darwinSystem {
      inherit system;
      modules = [
        hostPath
        home-manager.darwinModules.home-manager
        (mkHomeManagerModule {
          inherit system homePath;
          userName = userName;
        })
      ];
      specialArgs = genSpecialArgs system // {
        user-name = userName;
        host-name = hostName;
      };
    };

  nixosHosts = {
    nixos-desktop = {
      system = "x86_64-linux";
      userName = "key5n";
      hostPath = ./hosts/nixos-desktop/default.nix;
      homePath = ./homes/nixos-desktop/default.nix;
    };
    nixos-subdesktop = {
      system = "x86_64-linux";
      userName = "key5n";
      hostPath = ./hosts/nixos-subdesktop/default.nix;
      homePath = ./homes/nixos-subdesktop/default.nix;
    };
    nixos-wsl = {
      system = "x86_64-linux";
      userName = "key5n";
      hostPath = ./hosts/nixos-wsl/default.nix;
      homePath = ./homes/nixos-wsl/default.nix;
    };
    nixos-lab = {
      system = "x86_64-linux";
      userName = "key5n";
      hostPath = ./hosts/nixos-lab/default.nix;
      homePath = ./homes/nixos-lab/default.nix;
    };
  };

  darwinHosts = {
    Key5n-MacBook-Pro = {
      system = "aarch64-darwin";
      userName = "key5n";
      hostName = "Key5n-MacBook-Pro";
      hostPath = ./hosts/Key5n-MacBook-Pro/default.nix;
      homePath = ./homes/Key5n-MacBook-Pro/default.nix;
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

  nixosConfigurations = nixpkgs.lib.mapAttrs (
    _: host:
    mkNixosConfig {
      system = host.system;
      userName = host.userName;
      hostPath = host.hostPath;
      homePath = host.homePath;
    }
  ) nixosHosts;

  darwinConfigurations = nixpkgs.lib.mapAttrs (
    _: host:
    mkDarwinConfig {
      system = host.system;
      userName = host.userName;
      hostName = host.hostName;
      hostPath = host.hostPath;
      homePath = host.homePath;
    }
  ) darwinHosts;
}
