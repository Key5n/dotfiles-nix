{
  description = "My dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-23.11";
  };

  outputs = { self, nixpkgs, home-manager, ... }: {
    nixosConfigurations = {
      # Personal laptop
      my-nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
        ];
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
