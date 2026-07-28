# Install to WSL:

`.\download_alpine.ps1`:

```sh
$Distro = "alpine"
$InstallDir = "$env:LOCALAPPDATA\WSL\alpine"
$Rootfs = "$env:TEMP\alpine-minirootfs.tar.gz"

New-Item -ItemType Directory -Force $InstallDir | Out-Null

curl.exe -L `
  "https://dl-cdn.alpinelinux.org/alpine/v3.24/releases/x86_64/alpine-minirootfs-3.24.1-x86_64.tar.gz" `
  -o $Rootfs

wsl --import $Distro $InstallDir $Rootfs --version 2
wsl -d $Distro
```

# Configure

```sh
apk update
apk upgrade
apk add doas doas-sudo-shim
apk add bash wget curl git
apk add neovim tmux
apk add rsync ffmpeg imagemagick eza bat gnupg fzf jq zip unzip
apk add alpine-sdk # similar to build-essential
```

```sh
cargo install ripgrep fd-find tealdeer
uv tool install yt-dlp ruff
gah install lazygit zoxide
```
