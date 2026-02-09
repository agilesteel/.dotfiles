{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgsForFrequentUpdates.url = "github:nixos/nixpkgs";
    nixpkgsForJava.url = "github:nixos/nixpkgs?rev=ffbc9f8cbaacfb331b6017d5a5abb21a492c9a38";

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
        "x86_64-darwin"
      ];
    in
    flake-utils.lib.eachSystem supportedSystems (
      system:
      let
        pkgs = import ./pkgs.nix nixpkgs nixpkgsForJava nixpkgsForFrequentUpdates direnv-instant system;
      in
      {
        formatter = pkgs.nixfmt;

        packages.homeConfigurations.vlad = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = [
            ./home.nix
          ];
        };
      }
    );
}
