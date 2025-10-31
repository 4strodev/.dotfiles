# setting go paths
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOPATH/bin

# python commands
export PATH=$PATH:$HOME/.local/bin

# editor paths
export EDITOR=nvim
export VISUAL=code
export PATH=~/bin:$PATH

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"

# jetbrains
export JETBRAINS_SCRIPTS_FOLDER="$HOME/.local/share/JetBrains/Toolbox/scripts"
export PATH="$JETBRAINS_SCRIPTS_FOLDER:$PATH"

# dotnet
export PATH="$HOME/.dotnet/tools:$PATH"

# asdf
fpath=(${ASDF_DATA_DIR:-$HOME/.asdf}/completions $fpath)
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
