{
  config,
  pkgs,
  ...
}:
{
  home = {
    homeDirectory = if pkgs.stdenv.isLinux then "/home/vlad" else "/Users/vlad";

    packages = with pkgs; [
      alejandra
      asciiquarium
      bat
      bloop
      bottom
      btop
      cachix
      claude-code
      cmatrix
      cocogitto
      coreutils
      coursier
      cowsay
      curl
      delta
      direnv
      direnv-instant
      dive
      docker
      docker-compose
      doggo
      doppler
      duf
      dust
      eza
      fastfetch
      fd
      figlet
      fx
      fzf
      gh
      git
      glow
      gping
      graphviz
      gum
      htop
      ipfetch
      jdk
      jq
      k9s
      keychain
      kubectl
      lazydocker
      lazygit
      less
      lolcat
      lua51Packages.luarocks
      mosh
      ncdu
      neovim
      ngrok
      nix-direnv
      nixd
      nnn
      nodejs
      nvd
      ookla-speedtest
      openssl
      posting
      ripgrep
      ripgrep-all
      sbt
      scala-cli
      scalafmt
      scc
      sl
      sshs
      stow
      tailspin
      tig
      tree
      unzip
      wget
      wget2
      xdg-utils
      xq
      zip
      zsh
    ];

    stateVersion = "25.05";
    username = "vlad";
  };

  programs.home-manager.enable = true;
}
