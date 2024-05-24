{ pkgs, ...}: {

  home.packages = with pkgs; [
    volta
  ];

  home.sessionVariables = {
    VOLTA_HOME = "$HOME/.volta";
  };

  home.sessionPath = [
    "$VOLTA_HOME/bin"
  ];
}
