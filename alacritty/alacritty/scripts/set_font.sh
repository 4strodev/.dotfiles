#!/usr/bin/env sh

cd ~/.config/alacritty

ln --force "./fonts/$1.toml" ./settings/fonts.toml
touch ./settings/fonts.toml
