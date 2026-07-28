# Fixing sudo

```sh
su -
apt install sudo
/usr/sbin/usermod -aG sudo ss
```
--> relogin

# Configure ssh
ssh: `/etc/ssh/sshd_config` - disable password authentication

# Common tools

```sh
apt:
  nvim
  git
  curl
  wget
  tmux
  rsync
  ffmpeg # video conversion
  imagemagick # image conversion
  pipx
  mpv # video and audio
  socat # to control mpv through socket
  bluez bluez-tools
  eza # better ls
  bat # cat with wings
  gnupg
  fzf
  jq
  zip unzip

uv tool:
  yt-dlp # download youtube videos
  ruff

cargo:
  alacritty
  tealdeer
  viu
  ripgrep
  fd-find

binary:
  https://github.com/DECE2183/yamusic-tui
  https://github.com/bluetuith-org/bluetuith/
```

