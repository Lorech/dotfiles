### MARK: ZSH Configuration

export ZSH="$HOME/.oh-my-zsh"

DOTFILES="$HOME/.config"
ZSH_CUSTOM="$DOTFILES/zsh"

zstyle ':omz:update' mode auto # Update automatically

DISABLE_AUTO_TITLE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

### MARK: Plugin Configuration

source "$ZSH_CUSTOM/themes/catppuccin_macchiato-zsh-syntax-highlighting.zsh"

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE="20"
ZSH_AUTOSUGGEST_USE_ASYNC=1

### MARK: Source

source $ZSH/oh-my-zsh.sh

### MARK: User Configuration

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Use the Starship theme for ZSH
export STARSHIP_CONFIG="$DOTFILES/starship/starship.toml"
eval "$(starship init zsh)"

### MARK: Device configuration

# Sensitive tokens from a gitignored file, which may not exist.
if [ -f "$ZSH_CUSTOM/environments/tokens.sh" ]; then
  source "$ZSH_CUSTOM/environments/tokens.sh"
fi;

# Computer-specific tooling
case "$HOST" in
  MacBookPro)
    source "$ZSH_CUSTOM/environments/home.sh"
    ;;
  Lauris-M5.local)
    source "$ZSH_CUSTOM/environments/work.sh"
    ;;
esac

### MARK: Custom Aliases

alias "pip"="python3 -m pip"
alias "gct"="git_commit_timestamp"

### MARK: Custom Functions

# Autocommits all staged files with a timestamp as the commit message.
# Passing `push` as an argument to the function also pushes it upstream.
git_commit_timestamp() {
  if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    git add -A
    git commit -m "$(date '+%Y-%m-%d %H:%M:%S')"
    if [[ $1 == "push" ]]; then
      git push
    fi
  else
    echo "Not inside a git repository."
  fi
}
