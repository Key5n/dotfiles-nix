{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    slackdump
  ];
}
