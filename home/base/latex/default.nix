{
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    texliveFull
  ]
  # install skim in darwin
  ++ (pkgs.lib.optionals pkgs.stdenv.isDarwin [
    skimpdf
  ]);
}
