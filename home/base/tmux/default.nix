{ pkgs, ... }: {
  programs.tmux = {
    enable = true;
    mouse = true;
    keyMode = "vi";
  };
}
