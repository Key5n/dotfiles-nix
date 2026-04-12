{
  pkgs,
  lib,
  config,
  ...
}:
{
  programs.neovim = {
    enable = true;

    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

  };

  home.packages = with pkgs; [
    #-- python
    pyright
    ruff

    #-- nix
    nil
    nixfmt

    #-- bash
    bash-language-server
    shellcheck
    shfmt

    #-- lua
    stylua
    lua-language-server
    luajitPackages.luarocks-nix

    #-- latex
    texlab

    #-- javascript/typescript
    typescript-language-server
    vscode-langservers-extracted
    tailwindcss-language-server

    yaml-language-server
    # prettier
    prettierd
    marksman
    glow
    dockerfile-language-server
    # This is only necessary if you want to use auto_install feature with Treesitter
    # tree-sitter

    ripgrep
    gdu
    bottom
    fd
  ];

  home.activation.installAstroNvim = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${pkgs.rsync}/bin/rsync -avz --chmod=D2755,F744 ${./nvim}/ ${config.xdg.configHome}/nvim/
  '';

  home.activation.installJuliaLanguageServer = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${pkgs.julia-bin}/bin/julia --project=~/.julia/environments/nvim-lspconfig  \
      -e 'using Pkg; Pkg.add("LanguageServer")';
      # Pkg.add("SymbolServer") is maybe necessary
  '';
}
