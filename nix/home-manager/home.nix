{
  config,
  pkgs,
  ...
}: {
  home = {
    homeDirectory =
      if pkgs.stdenv.isLinux
      then "/home/vlad"
      else "/Users/vlad";

    packages = with pkgs; [
      alejandra
      asciiquarium
      bat
      bloop
      bottom
      btop
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
      dogdns
      doppler
      duf
      dust
      eza
      fd
      figlet
      fx
      fzf
      gh
      git
      glow
      graphviz
      gum
      htop
      ipfetch
      jdk
      jq
      k9s
      keychain
      kubectl
      less
      lolcat
      mosh
      # ncdu
      neofetch
      neovim
      ngrok
      nix-direnv
      nixd
      nnn
      nvd
      ookla-speedtest
      # pulumi
      ripgrep
      ripgrep-all
      sbt
      scala-cli
      scalafmt
      scc
      sl
      stow
      tailspin
      tig
      tree
      unzip
      xq
      zip
      zsh
    ];

    stateVersion = "23.05";
    username = "vlad";
  };

  programs.home-manager.enable = true;
}
