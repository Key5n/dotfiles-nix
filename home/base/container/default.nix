{ pkgs, ... }: {
  home.packages = with pkgs; [
    docker
    dive
    lazydocker
  ];
}
