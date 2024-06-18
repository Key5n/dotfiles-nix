{
  pkgs,
  config,
  ...
}: {
  xdg.configFile."zsh/p10k.zsh".source = ./.p10k.zsh;

  programs.zsh = {
    initExtra = ''
      source ~/.config/zsh/p10k.zsh
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
    '';
  };
}
