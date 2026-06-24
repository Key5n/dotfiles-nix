{
  pkgs,
  lib,
  config,
  ...
}:
let
  npmBin = "${config.home.homeDirectory}/.npm/bin";
in
{
  home.packages = with pkgs; [
    nodejs_24
    corepack_24
  ];

  programs.bash = lib.mkIf config.programs.bash.enable {
    bashrcExtra = ''
      export PATH="$PATH:${npmBin}"
    '';
  };

  programs.zsh = lib.mkIf config.programs.zsh.enable {
    initContent = ''
      export PATH="$PATH:${npmBin}"
    '';
  };

  home.file.".npmrc".text = ''
    prefix=${config.home.homeDirectory}/.npm
  '';
}
