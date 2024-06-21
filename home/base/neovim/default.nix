{ pkgs, lib, config,... }: {
  programs.neovim = {
    enable = true;
  };

  home.packages = with pkgs; [
    ripgrep
  ];

  home.activation.installAstroNvim = lib.hm.dag.entryAfter ["writeBoundary"] ''
    ${pkgs.rsync}/bin/rsync -avz --chmod=D2755,F744 ${./nvim}/ ${config.xdg.configHome}/nvim/
  '';
}
