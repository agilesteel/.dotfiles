#!/bin/bash

nixpkgs=()

while read package; do
  nixpkgs+=(nixpkgs.$package)
done < ~/.dotfiles/setup/nixpkgs

nix-env -iA "${nixpkgs[@]}"
