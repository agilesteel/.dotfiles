#!/bin/bash

while read package; do
  nix-env -iA nixpkgs.$package
done < ~/.dotfiles/setup/nixpkgs
