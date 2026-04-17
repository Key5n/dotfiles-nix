{ pkgs, ... }:
let
  # pkgs.poppler-utils omits the following error:
  # > pkgs.buildEnv error: two given paths contain a conflicting subpath:
  # >   `/nix/store/18aj8ymdp9byw7fnrxhv6y9s6hfbwxn1-poppler-glib-25.10.0/lib/libpoppler.so.154.0.0' and
  # >   `/nix/store/nz7lr2smd029kzzdb0bm7h7azszcxv03-poppler-utils-25.10.0/lib/libpoppler.so.154.0.0'
  # > hint: this may be caused by two different versions of the same package in buildEnv's `paths` parameter
  # > hint: `pkgs.nix-diff` can be used to compare derivations
  popplerUtilsBinOnly = pkgs.runCommandLocal "poppler-utils-bin-only" { } ''
    mkdir -p "$out/bin"
    for tool in ${pkgs.poppler-utils}/bin/*; do
      ln -s "$tool" "$out/bin/$(basename "$tool")"
    done
  '';
in
{
  home.packages = with pkgs; [
    popplerUtilsBinOnly
    python314Packages.pypdf
    python314Packages.reportlab
    python314Packages.pdfplumber
  ];

  home.file.".codex/skills/pdf".source = ../pdf;
}
