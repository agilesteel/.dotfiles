{
  config,
  pkgs,
  ...
}: {
  home = {
    homeDirectory = if pkgs.stdenv.isLinux then "/home/vlad" else "/Users/vlad";

    packages = with pkgs; [
      asciiquarium
      bat
      bottom
      cachix
      cmatrix
      cocogitto
      coreutils
      coursier
      cowsay
      delta
      direnv
      dive
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
      graphviz
      gum
      heroku
      htop
      ipfetch
      jdk
      keychain
      less
      lolcat
      mosh
      ncdu
      neofetch
      neovim
      ngrok
      nix-direnv
      nvd
      ookla-speedtest
      pulumi
      ripgrep
      ripgrep-all
      scala-cli
      sl
      stow
      tig
      tree
      unzip
      zip
      zsh
    ];

    stateVersion = "23.05";
    username = "vlad";
  };


  programs.home-manager.enable = true;
}
