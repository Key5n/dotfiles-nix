{ pkgs, lib, config,... }: {
  programs.neovim = {
    enable = true;

    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

  };

  home.packages = with pkgs; [
    #-- python
    pyright
    python312Packages.flake8

    #-- nix
    nil

    #-- bash
    nodePackages.bash-language-server
    shellcheck
    shfmt

    #-- lua
    stylua
    lua-language-server

    #-- latex
    texlab

    #-- javascript/typescript
    nodePackages.typescript-language-server
    nodePackages.vscode-langservers-extracted
    nodePackages."@tailwindcss/language-server"

    nodePackages.yaml-language-server
    # nodePackages.prettier
    prettierd
    marksman
    glow
    nodePackages.dockerfile-language-server-nodejs
    # This is only necessary if you want to use auto_install feature with Treesitter
    # tree-sitter

    ripgrep
    gdu
    bottom
    fd
  ];

  home.activation.installAstroNvim = lib.hm.dag.entryAfter ["writeBoundary"] ''
    ${pkgs.rsync}/bin/rsync -avz --chmod=D2755,F744 ${./nvim}/ ${config.xdg.configHome}/nvim/
  '';

  home.activation.installJuliaLanguageServer = lib.hm.dag.entryAfter ["writeBoundary"] ''
    ${pkgs.julia-bin}/bin/julia --project=~/.julia/environments/nvim-lspconfig  \
      -e 'using Pkg; Pkg.add("LanguageServer")';
      # Pkg.add("SymbolServer") is maybe necessary
  '';
}
