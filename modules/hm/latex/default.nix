{
  pkgs,
  ...
}:
{
  home.packages =
    with pkgs;
    [
      texliveFull
      newcomputermodern
    ]
    ++ (pkgs.lib.optionals pkgs.stdenv.isLinux [
      zathura
    ])
    # install skim in darwin
    ++ (pkgs.lib.optionals pkgs.stdenv.isDarwin [
      skimpdf
    ]);
}
