{
  pkgs,
  ...
}: {
  home.packages = [
    pkgs.poetry
    pkgs.python312
  ];
}
