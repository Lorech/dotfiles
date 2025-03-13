# dotfiles

My personal configurations for various tools and configurable software I use on a daily basis. Compatible (with some differences) with macOS and Linux.

## Setup

> [!WARNING]
> Although I tried to be as descriptive as possible with my setup instructions, I have yet to set up a computer from scratch using this repository as a base, so I don't know how it actually behaves when directly cloned.
>
> For the most part, it should be fine, as most of these tools must be manually installed, but I can't guarantee that everything is accurate and won't cause issues.

1. Clone the repository into `~/.config/`
2. Install the respective tooling for your operating system
3. For some tools, additional action is required - see below for any tool you plan to use

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

The default configuration for LSP and formatting uses a big batch of various languages that I am likely to use at some point on any computer which will definitely cause errors whenever Neovim is opened, unless you happen to have tooling installed for all of these languages. For this reason, you willwant to update `nvim/lua/plugins/{conform,lsp}.lua` to match your needs.

In general, due to this bad design, I have plans to figure out a way to make these environment-configurable, which would relegate the default values in the repository root just enough to use as an example, but I have yet to free the time for it.
</details>

<details>
<summary>Starship</summary>

This is not documented yet.

TLDR: Configure your shell to use Starship
</details>

<details>
<summary>Tmux</summary>

This is not documented yet.

TLDR: Install Tmux Plugin Manager
</details>

<details>
<summary>ZSH</summary>

This is not documented yet.

I don't have a TLDR either, as I have not even compiled a configuration yet, sorry.
</details>
