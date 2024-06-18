{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
  };

  # xdg.configFile."nvim".source = pkgs.fetchFromGitHub {
  #   owner = "AstroNvim";
  #   repo = "template";
  #   rev = "main";
  #   sha256 = "bwabCS0oeH7yi+GWIj/0vHgr/6fLDFFgZhtM1GhKlok=";
  # };

  xdg.configFile."nvim" = {
    source = ./nvim;
    recursive = true;
  };
}
