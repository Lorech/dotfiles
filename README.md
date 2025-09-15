# dotfiles

My personal configurations for various tools and configurable software I use on a daily basis on macOS systems.

## Setup

> [!WARNING]
> These setup instructions should theoretically work, but I have yet to do a full computer setup from scratch, so they are untested.

1. Clone the repository and its submodules into `~/.config`:

```sh
git clone git@github.com:Lorech/dotfiles.git ~/.config --recurse-submodules
```

2. Install the respective tooling for your operating system
3. For some tools, additional action is required - see below for any tool you plan to use

<details>
<summary>Neovim</summary>

Development plugins (LSP and code formatting) are split between different computers, allowing installation and configuration only for languages that are required on a specific computer, as my personal and my work needs may be different.

The main configuration happens inside `nvim/lua/plugins/{conform,lsp}/init.lua`, which loads one of the nearby configuration based on the running computer's hostname, which allows it to be extensible and flexible.

Neovim is configured to use GitHub Copilot using [Code Companion](https://github.com/olimorris/codecompanion.nvim) via [`copilot.lua`](https://github.com/olimorris/codecompanion.nvim). For this integration to work, you must have a GitHub account with an active subscription to Copilot, and authorize the plugin to use your subscription when first launching Neovim:

```sh
:Copilot auth
```
</details>

<details>
<summary>Starship</summary>

Currently undocumented.

TLDR: Configure your shell to use Starship
</details>

<details>
<summary>Tmux</summary>

Currently undocumented.

TLDR: Install Tmux Plugin Manager
</details>

<details>
<summary>ZSH</summary>

The ZSH configuration uses [`oh-my-zsh`](https://github.com/ohmyzsh/ohmyzsh), which needs to be manually installed before it can be used. Follow the installation instructions in the README file at the linked repository. Once installed, the ZSH configuration can be symlinked for use on the system:

```sh
ln -s ~/.config/.zshrc ~/.zshrc
```

Any plugins that are installed to be used together with `oh-my-zsh` should be cloned with the existing Git submodules in the repository, and should therefore work out of the box.
</details>

