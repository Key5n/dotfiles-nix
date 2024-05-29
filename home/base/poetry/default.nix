{
  pkgs,
  ...
}: {
  home.packages = [
    pkgs.poetry
  ];
}