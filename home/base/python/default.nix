{
  pkgs,
  ...
}:
{
  home.packages = [
    pkgs.python312
    pkgs.black
    pkgs.uv
  ];
}
