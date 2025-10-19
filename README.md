# dotfiles

My personal configurations for various tools and configurable software I use on a daily basis. Compatible (with some differences) with both macOS and Linux.

## Setup

> [!WARNING]
> These setup instructions should theoretically work, but I have yet to do a full computer setup from scratch, so they are untested.

1. Clone the repository and its submodules into `~/.config`:

```sh
git clone git@github.com:Lorech/dotfiles.git ~/.config --recurse-submodules
```

2. Install desired tools for your operating system
3. Review the below summaries for any additional setup work or system dependencies required for a fully functional setup

<details>
<summary>GTK</summary>

From what I could tell, GTK 3 and GTK 4 could not be configured via settings file - theming only worked through terminal commands, which is why I didn't include GTK in the installer list, as this is fully manual and totally optional.

To ensure a consistent style across the entire OS, I use a GTK theme which can provide a Catppuccin theme, as it is the most universal across the largest amount of applications I use - [Colloid](https://github.com/vinceliuice/Colloid-gtk-theme), along with its' respective [Colloid Icons](https://github.com/vinceliuice/Colloid-icon-theme).

To set these up, you must clone the repositories locally, and run the following commands to match my setup:

```sh
colloid-gtk/install.sh -t purple -c dark --tweaks catppuccin normal
colloid-icons/install.sh -s catppuccin -t purple./install.sh -s catppuccin -t purple./install.sh -s catppuccin -t purple
gsettings set org.gnome.desktop.interface gtk-theme Colloid-Purple-Dark-Catppuccin
gsettings set org.gnome.desktop.interface icon-theme Colloid-Purple-Catppuccin-Dark
```
</details>

<details>
<summary>Hyprpaper</summary>

Due to copyright risk, I do not store any wallpapers in this repository, so I also don't think it's appropriate to store wallpaper configuration here as well. For this reason, the Hyprpaper configuration only contains a template file for setting up.

You can copy this file naming it `hyprpaper.conf` (this file is ignored from VCS) and fill in the templated fields to make Hyprpaper functional.
</details>

<details>
<summary>Neovim</summary>

For a fully functional configuration, the following system dependencies are required:

- ripgrep (https://github.com/BurntSushi/ripgrep)
- fd (https://github.com/sharkdp/fd)

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

In addition to `oh-my-zsh`, [`eza`](https://github.com/eza-community/eza) has been aliased as a replacement for the native `ls` command, and must be installed based on the install instructions from their README.
</details>
