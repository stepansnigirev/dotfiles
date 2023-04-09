# Notes on Framework laptop

## Brightness fix:

Add a line to `/etc/modprobe.d/framework-als-blacklist.conf`:

```
blacklist hid_sensor_hub
```

Run `sudo update-initramfs -u` and reboot.

## Grub customizations:

Check out [fallout theme](https://github.com/shvchk/fallout-grub-theme)
