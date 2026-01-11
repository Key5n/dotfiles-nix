{
  pkgs,
  lib,
  config,
  ...
}:
{
  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    autocd = true;

    shellAliases = {
      ll = "ls -l";
      la = "ls -la";
      c = "code -r";
      e = "exit";
    }
    // lib.optionalAttrs (lib.elem pkgs.lazygit config.home.packages) {
      lag = "lazygit";
    }
    // lib.optionalAttrs (lib.elem pkgs.lazydocker config.home.packages) {
      lad = "lazydocker";
    };

    plugins = [
      {
        name = "zsh-autocomplete";
        src = pkgs.fetchFromGitHub {
          owner = "marlonrichert";
          repo = "zsh-autocomplete";
          rev = "23.07.13";
          sha256 = "0NW0TI//qFpUA2Hdx6NaYdQIIUpRSd0Y4NhwBbdssCs=";
        };
      }
    ];

    initContent = lib.mkIf pkgs.stdenv.isLinux ''
      bindkey "''${key[Up]}" up-line-or-search
    '';
  };
}
