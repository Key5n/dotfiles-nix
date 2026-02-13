{
  pkgs,
  ...
}:
{
  home.packages = [
    pkgs.python312
    pkgs.ruff
    pkgs.uv
  ];
}
