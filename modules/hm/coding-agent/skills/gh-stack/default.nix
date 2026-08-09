{ pkgs, ... }: {
  home.packages = with pkgs; [
    gh
    gh-stack
    git
  ];

  programs.git.settings.rerere.enabled = true;

  home.file.".codex/skills/gh-stack".source = ../gh-stack;
}
