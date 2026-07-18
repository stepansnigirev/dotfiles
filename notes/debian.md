# Fixing sudo
su -
apt install sudo
/usr/sbin/usermod -aG sudo ss
> relogin

# Configure ssh
ssh: `/etc/ssh/sshd_config` - disable password authentication

# Common tools
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

uv tools:
  yt-dlp # download youtube videos

cargo:
  alacritty
  tealdeer
  viu

binary:
  https://github.com/DECE2183/yamusic-tui
  https://github.com/bluetuith-org/bluetuith/

# Suckless
dwm + st + surf:
  sudo apt install build-essential git libx11-dev libxft-dev libxinerama-dev
  git clone https://git.suckless.org/dwm
  sudo make clean install
  echo "exec dwm" > ~/.xinitrc
  sudo apt install xorg xinit st alacritty
  startx

