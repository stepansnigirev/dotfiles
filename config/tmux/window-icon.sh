#!/usr/bin/env bash
case "$1" in
    nvim|vim)
        printf ''
        ;;
    python|python3|ipython)
        printf ''
        ;;
    git|lazygit|lg)
        printf ''
        ;;
    htop|btop|top)
        printf ''
        ;;
    man|less)
        printf '󰈙'
        ;;
    *)
        printf ''
        ;;
esac
