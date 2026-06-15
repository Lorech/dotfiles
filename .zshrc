### MARK: ZSH Configuration

DOTFILES="$HOME/.config"
ZSH_CUSTOM="$DOTFILES/zsh"

DISABLE_AUTO_TITLE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

export XDG_CONFIG_HOME="$DOTFILES"

# Enable search-by-prefix. Is this needed? Always worked without extra configuration...
autoload up-line-or-beginning-search
autoload down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "\e[A" up-line-or-beginning-search
bindkey "\e[B" down-line-or-beginning-search

### MARK: Plugin Configuration

source "$ZSH_CUSTOM/themes/catppuccin_macchiato-zsh-syntax-highlighting.zsh"
source "$ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"

ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE="20"
ZSH_AUTOSUGGEST_USE_ASYNC=1

### MARK: User Configuration

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Use the Starship theme for zsh
export STARSHIP_CONFIG="$DOTFILES/starship/starship.toml"
eval "$(starship init zsh)"

# Pre-configure fzf for zsh
export FZF_TMUX_OPTS="-p 90%,70%"
eval "$(fzf --zsh)"

# Pre-configure zoxide for zsh
eval "$(zoxide init zsh --cmd cd)"

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

alias pip='python3 -m pip'
alias todos='rg -i "TODO|FIXME|HACK|XXX" --color=always'

# Simplify common actions via fuzzy-finding
alias fkill='kill $(ps aux | fzf | awk '"'"'{print $2}'"'"')'
alias fe='$EDITOR $(fzf --preview "bat --color=always {}")'
alias fbr='git checkout $(git branch | fzf)'

# Replace native commands with third-party modified executables
alias ls='eza --icons'
alias ll='eza -l --git --icons'
alias la='eza -la --git --icons'
alias lt='eza --tree --level=2 --icons'
alias cat='bat'
alias diff='delta'

### MARK: Custom Functions

# Autocommits all staged files with a timestamp as the commit message.
# Passing `push` as an argument to the function also pushes it upstream.
alias gct='git_commit_timestamp'
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
