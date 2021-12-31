#!/bin/bash

# install nix
# curl -L https://nixos.org/nix/install | sh

# source ~/.bashrc

while read package; do
  nix-env -iA nixpkgs.$package
done < ~/.dotfiles/setup/nixpkgs
