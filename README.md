# NeoVim

## Set config

```sh
cp -r ./config/* ~/.config/
cp .tmux.conf ~/
```

## Install Vim-Plug

```sh
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

Then in vim use `:PlugInstall`

## Install fonts

Nerdfont:

```sh
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/Ubuntu.zip
unzip Ubuntu.zip -d ~/.fonts
fc-cache -fv
```

For powerline fonts check [this doc](https://powerline.readthedocs.io/en/master/installation/linux.html#fonts-installation)

## LSP config

Python: uses `ruff-lsp`, install with `pip` or `pipx`

## Install `ctags`

It is useful for jumping to function definition and autocomplete.

```sh
sudo apt install exuberant-ctags
```

# Tmux

Install [TMP](https://github.com/tmux-plugins/tpm):

```sh
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Then copy `.tmux.conf` to your home directory (requires powerline fonts).

In `tmux` press `C+b I` to install plugins.

# Zellij

Another terminal multiplexer that supports sixel out of the box.

To copy to clipboard on wayland do `sudo apt install wl-clipboard`

# Better bash

Interesting options:
- [starship](https://starship.rs/) is my preferred one
- default [powerline](https://github.com/b-ryan/powerline-shell), written in python so it's a bit laggy
- [powerline-rust](https://github.com/cirho/powerline-rust) which works reasonably well

# LazyVim

An interesting project is [`LazyVim`](https://www.lazyvim.org/) - it requires pretty
recent neovim, that can be downloaded from [neovim repo](https://github.com/neovim/neovim/releases/tag/stable).

Also requires `ripgrep` and `fd-find` that can be installed with `cargo`.

For me it adds too much noize, so I have a less feature-rich version.

# Toolz

- [Neovim](https://neovim.io/) - a better version of vim (`nix-env -iA nixpkgs.neovim`)
- [ripgrep](https://github.com/BurntSushi/ripgrep) - nice replacement for `grep` (`cargo install ripgrep`)
- [fd-find](https://github.com/sharkdp/fd) - convenient file search (`cargo install fd-find`)
- [bat](https://github.com/sharkdp/bat) - better `cat` (`cargo install bat`)
- [tldr](https://tldr.sh/) - condensed help on unix commands (rust client: `cargo install tealdeer`)
- [Starship](https://starship.rs/) for more info in terminal status line, highly configurable (`cargo install starship`)
- [nerdfonts](https://www.nerdfonts.com/) - icons in terminal, suppoorted by many cli tools including vim plugins
- [tmux](https://github.com/tmux/tmux/wiki) - terminal multiplexer
- [mpv](https://mpv.io/) - player, can play from youtube `nix-env -iA nixpkgs.mpv-unwrapped`
- [yt-dlp](https://github.com/yt-dlp/yt-dlp) - youtube downloader, `pipx install yt-dlp`
- [foot](https://codeberg.org/dnkl/foot) - wayland terminal with sixel support (`sudo apt install foot`)
- [libsixel](https://github.com/libsixel/libsixel) - toolz for sixel graphics, i.e. `img2sixel` (`nix-env -iA nixpkgs.libsixel`)
- [ranger](https://github.com/ranger/ranger) - file manager. `pipx install ranger-fm`
- [glow](https://github.com/charmbracelet/glow) - markdown render tui
- [delta](https://github.com/dandavison/delta) - nice git diff tool
- [jump](https://github.com/gsamokovarov/jump) - quick jump between folders

