# Dotfiles

## Set config

```sh
cp -r ./config/* ~/.config/
```

## Install fonts

Nerdfont:

```sh
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip
unzip JetBrainsMono.zip -d ~/.fonts
fc-cache -fv
```

## Neovim LSP config

Python: uses `ruff` and `ty`, install with `uv`, `pip` or `pipx`

# Toolz

- [neovim](https://neovim.io/)
- [ripgrep](https://github.com/BurntSushi/ripgrep) - nice replacement for `grep` (`cargo install ripgrep`)
- [fd-find](https://github.com/sharkdp/fd) - convenient file search (`cargo install fd-find`)
- [bat](https://github.com/sharkdp/bat) - better `cat` (`cargo install bat`)
- [tldr](https://tldr.sh/) - condensed help on unix commands (rust client: `cargo install tealdeer`)
- [starship](https://starship.rs/) for more info in terminal status line, highly configurable
- [nerdfonts](https://www.nerdfonts.com/) - icons in terminal, suppoorted by many cli tools including vim plugins
- [tmux](https://github.com/tmux/tmux/wiki) - terminal multiplexer
- [mpv](https://mpv.io/) - player, can play from youtube
- [yt-dlp](https://github.com/yt-dlp/yt-dlp) - youtube downloader, `pipx install yt-dlp`
- [glow](https://github.com/charmbracelet/glow) - markdown render tui
- [delta](https://github.com/dandavison/delta) - nice git diff tool (`cargo install git-delta`)
- [lazygit](https://github.com/jesseduffield/lazygit) - git tui (`gah install lazygit`)
- [zoxide](https://github.com/ajeetdsouza/zoxide) - quick jump between folders
- [fzf](https://github.com/junegunn/fzf) - fuzzy finder (required by zoxide for interactive search) - `sudo apt install fzf`
- [notcurses](https://github.com/dankamongmen/notcurses/) - lib for tui + ncplayer terminal viewer
- [eza](https://github.com/eza-community/eza) - better `ls`
- [viu](https://github.com/atanunq/viu) - image viewer in terminal
- [gah](https://github.com/get-gah/gah) - install packages from github releases
