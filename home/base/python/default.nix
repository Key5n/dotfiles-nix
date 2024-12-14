{
  pkgs,
  ...
}: {
  home.packages = [
    pkgs.python312
    pkgs.black
  ];

  programs.poetry = {
    enable = true;
  };
}
