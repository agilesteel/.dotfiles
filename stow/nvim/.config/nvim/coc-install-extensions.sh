#!/bin/bash

set -o nounset    # error when referencing undefined variable
set -o errexit    # exit when command fails

# Install extensions
mkdir -p ~/.config/coc/extensions
cd ~/.config/coc/extensions
if [ ! -f package.json ]; then
  echo '{"dependencies":{}}'> package.json
fi

npm install coc-explorer coc-html coc-css coc-json coc-yaml --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod
