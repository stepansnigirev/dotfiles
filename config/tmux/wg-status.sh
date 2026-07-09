#!/usr/bin/env bash

ifaces=$(
  ip -o link show type wireguard 2>/dev/null |
    awk -F': ' '{gsub(/@.*/, "", $2); print $2}' |
    paste -sd ',' -
)

if [ -n "$ifaces" ]; then
  printf "#[fg=#1e1e1e] ⇄ %s #[default]" "$ifaces"
fi
