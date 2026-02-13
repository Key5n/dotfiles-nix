{ lib, config, ... }:
let
  schemes = {
    iceberg = import ./iceberg.nix;
    "tokyo-night" = import ./tokyo-night.nix;
    "gruvbox-dark" = import ./gruvbox-dark.nix;
    "catppuccin-mocha" = import ./catppuccin-mocha.nix;
    nord = import ./nord.nix;
  };
  schemeNames = builtins.attrNames schemes;
in
{
  options.colorscheme = {
    name = lib.mkOption {
      type = lib.types.enum schemeNames;
      default = "iceberg";
      description = "Active colorscheme name.";
    };
    theme = lib.mkOption {
      type = lib.types.attrs;
      readOnly = true;
      description = "Resolved colorscheme theme values.";
    };
  };

  config = {
    colorscheme.theme = schemes.${config.colorscheme.name};
  };
}
