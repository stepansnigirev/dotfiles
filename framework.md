# Notes on Framework laptop

## Brightness fix:

Add a line to `/etc/modprobe.d/framework-als-blacklist.conf`:

```
blacklist hid_sensor_hub
```

Run `sudo update-initramfs -u` and reboot.

## Fingerprint installation

From https://wiki.debian.org/SecurityManagement/fingerprint%20authentication

```
sudo apt install fprintd libpam-fprintd
fprintd-enroll
fprintd-verify
sudo pam-auth-update
```

Now sudo and Gnome can ask for fingerprint

## Grub customizations:

Check out [fallout theme](https://github.com/shvchk/fallout-grub-theme)
