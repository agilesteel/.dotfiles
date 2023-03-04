{
  config,
  pkgs,
  ...
}: {
  home = {
    homeDirectory = "/home/vlad";

    packages = with pkgs; [
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

    stateVersion = "22.11";
    username = "vlad";
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };

  programs.home-manager.enable = true;
}
