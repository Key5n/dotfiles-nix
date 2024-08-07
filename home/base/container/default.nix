{ pkgs, ... }: {
  home.packages = with pkgs; [
    docker-compose
    dive
    lazydocker
  ];
}
