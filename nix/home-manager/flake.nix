{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgsForFrequentUpdates.url = "github:nixos/nixpkgs";
    nixpkgsForJava.url = "github:nixos/nixpkgs?rev=040ad577fef7b972d7e92cd1db79b9c9b697844a";

    flake-utils = {
      url = "github:numtide/flake-utils";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    nixpkgsForJava,
    nixpkgsForFrequentUpdates,
    flake-utils,
    home-manager,
    ...
  }: let
    supportedSystems = [
      "aarch64-darwin"
      "aarch64-linux"
      "x86_64-linux"
      "x86_64-darwin"
    ];
  in
    flake-utils.lib.eachSystem supportedSystems (
      system: let
        pkgs = import ./pkgs.nix nixpkgs nixpkgsForJava nixpkgsForFrequentUpdates system;
      in {
        formatter = pkgs.alejandra;

        packages.homeConfigurations.vlad = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = [
            ./home.nix
          ];
        };
      }
    );
}
