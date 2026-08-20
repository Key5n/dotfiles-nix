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
    ++ (pkgs.lib.optionals pkgs.stdenv.hostPlatform.isLinux [
      zathura
    ])
    # install skim in darwin
    ++ (pkgs.lib.optionals pkgs.stdenv.hostPlatform.isDarwin [
      skimpdf
    ]);
}
