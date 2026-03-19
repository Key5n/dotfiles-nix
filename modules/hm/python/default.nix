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

  home.file."flakes/python312.nix".source = ./python312.nix;
}
