{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgsForFrequentUpdates.url = "github:nixos/nixpkgs";
    nixpkgsForJava.url = "github:nixos/nixpkgs?rev=2f17caa8d7c8c198dbb06d0c1c4a71b29f0a4f11";

    direnv-instant = {
      url = "github:Mic92/direnv-instant";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nixpkgsForJava,
      nixpkgsForFrequentUpdates,
      direnv-instant,
      flake-utils,
      home-manager,
      ...
    }:
    let
      supportedSystems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-linux"
      ];
    in
    flake-utils.lib.eachSystem supportedSystems (
      system:
      let
        pkgs = import ./pkgs.nix nixpkgs nixpkgsForJava nixpkgsForFrequentUpdates direnv-instant system;

        homeConfiguration = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = [
            ./home.nix
          ];
        };
      in
      {
        formatter = pkgs.nixfmt-tree;

        legacyPackages.homeConfigurations.vlad = homeConfiguration;

        packages.default = homeConfiguration.activationPackage;
      }
    );
}
