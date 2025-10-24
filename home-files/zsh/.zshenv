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

alias git-alias='less $HOME/.zim/modules/git/init.zsh'
alias devim='nvim -u $HOME/.config/nvim/devinit.lua'
alias cleanvim='nvim -u NORC'

source <(fzf --zsh)

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"


# Start the GPG agent if it's not already running
if ! gpgconf --list-dirs agent-socket > /dev/null 2>&1; then
    eval $(gpg-agent --daemon --write-env-file "$HOME/.gpg-agent-info")
fi

# Load the GPG agent environment variables if they exist
if [ -f "$HOME/.gpg-agent-info" ]; then
    source "$HOME/.gpg-agent-info"
    export GPG_AGENT_INFO
    export SSH_AUTH_SOCK
    export SSH_AGENT_PID
fi

# Ensure GPG TTY is set correctly
export GPG_TTY=$(tty)

# Loading extra env vars
if [ -f "$HOME/.zshcustom" ]; then
    source "$HOME/.zshcustom"
fi
