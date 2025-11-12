#!/usr/bin/env sh

cd ~/.config/alacritty

ln --force "./themes/$1.toml" ./settings/theme.toml
touch ./settings/theme.toml
