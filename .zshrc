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

### MARK: Custom Aliases

alias "ls"="eza --icons"
alias "ls -la"="eza -l -g --icons"
alias "pip"="python3 -m pip"

### MARK: User Configuration

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Start Hyprland together with the login shell on my Arch desktop.
if [[ "$HOST" == "Fractal" ]] then
  if uwsm check may-start; then
    exec uwsm start hyprland.desktop
  fi
fi

# Use the Eza theme configuration from this directory
export EZA_CONFIG_DIR="$DOTFILES/eza"

# Use the Starship theme for ZSH
export STARSHIP_CONFIG="$DOTFILES/starship/starship.toml"
eval "$(starship init zsh)"
