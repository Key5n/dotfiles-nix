{
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    texliveFull
    newcomputermodern
  ]
  # install skim in darwin
  ++ (pkgs.lib.optionals pkgs.stdenv.isDarwin [
    skimpdf
  ]);
}
