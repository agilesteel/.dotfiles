{ config, pkgs, ... }:

{
  home.username = "vlad";
  home.homeDirectory = "/home/vlad";

  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = _: true;

  home.packages = with pkgs; [
    asciiquarium
    bat
    bottom
    cachix
    cmatrix
    coursier
    cowsay
    delta
    direnv
    docker
    docker-compose
    doppler
    duf
    fd
    figlet
    fx
    fzf
    gh
    git
    glow
    graalvm17-ce
    graphviz
    gum
    heroku
    htop
    ipfetch
    keychain
    less
    lolcat
    mosh
    ncdu
    neofetch
    neovim
    nix-direnv
    ookla-speedtest
    pulumi
    ripgrep
    ripgrep-all
    scala-cli
    sl
    stow
    sublime4
    tig
    tree
    wl-clipboard
    zsh
  ];
}
