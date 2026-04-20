export PATH="$HOME/.local/bin:$PATH"

export PATH="$PATH:$HOME/.rvm/bin"

export PATH="$HOME/Library/Python/3.9/bin:$PATH"

export PATH=~/Library/Android/sdk/tools:$PATH
export PATH=~/Library/Android/sdk/platform-tools:$PATH

export ANDROID_HOME=~/Library/Android/sdk

PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

export NVM_DIR="$DOTFILES/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
