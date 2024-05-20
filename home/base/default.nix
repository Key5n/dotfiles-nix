{ pkgs, ...}: {

  home.packages = with pkgs; [
    just
    psmisc
  ];

}
