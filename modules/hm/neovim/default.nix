{
  pkgs,
  lib,
  config,
  ...
}:
let
  # the path to nvim directory
  # to make this symlink work, we need to git clone this repo to your home directory.
  configPath = "${config.home.homeDirectory}/dotfiles-nix/modules/hm/neovim/nvim";
in
{
  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink configPath;

  programs.neovim = {
    enable = true;

    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    sideloadInitLua = true;
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

  home.activation.installJuliaLanguageServer = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${pkgs.julia-bin}/bin/julia --project=~/.julia/environments/nvim-lspconfig  \
      -e 'using Pkg; Pkg.add("LanguageServer")';
      # Pkg.add("SymbolServer") is maybe necessary
  '';
}
