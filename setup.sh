#!/bin/bash

## TODO: Check if brew is installed

## Install some things, not all are needed
brew install gcc gh neovim node ripgrep

## For marksman, so that the outlines would work in Quarto files
mkdir -p ~/.config/marksman
echo "[core]" > ~/.config/marksman/config.toml
echo "markdown.file_extensions = [\"md\", \"markdown\", \"qmd\"]" >> ~/.config/marksman/config.toml
