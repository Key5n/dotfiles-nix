{
  pkgs,
  ...
}: {
  home.packages = [
    pkgs.python312
  ];

  programs.poetry = {
    enable = true;
  };
}
