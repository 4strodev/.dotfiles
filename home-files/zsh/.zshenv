. "$HOME/.cargo/env"

# setting go paths
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# volta
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# python commands
export PATH=$PATH:$HOME/.local/bin

# Composer
export PATH=$PATH:$HOME/.config/composer/vendor/bin

# General configurations
export EDITOR_THEME="zephyr"

# editor paths
export EDITOR=nvim
export VISUAL=code
export PATH=~/bin:$PATH

# flutter env variables
export CHROME_EXECUTABLE=/usr/bin/brave
export PATH="$PATH:/home/astro/.flutter_install/flutter/bin"

export WASMTIME_HOME="$HOME/.wasmtime"
export PATH="$WASMTIME_HOME/bin:$PATH"

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"

# jetbrains
export JETBRAINS_SCRIPTS_FOLDER="$HOME/.local/share/JetBrains/Toolbox/scripts"
export PATH="$JETBRAINS_SCRIPTS_FOLDER:$PATH"

# fly.io
export FLYCTL_INSTALL="/home/astro/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"

# emacs
export PATH="$HOME/.config/emacs/bin:$PATH"

# dotnet
export PATH="$HOME/.dotnet/tools:$PATH"

# ruby
export GEM_HOME="$(gem env user_gemhome)"
export PATH="$PATH:$GEM_HOME/bin"
