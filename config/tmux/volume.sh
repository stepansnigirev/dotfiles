#!/usr/bin/env bash

volume_info=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null)

if [[ -z "$volume_info" ]]; then
    printf ""
    exit 0
fi

volume=$(awk '{printf "%.0f", $2 * 100}' <<< "$volume_info")

if [[ "$volume_info" == *"[MUTED]"* ]]; then
    icon="#[fg=colour210]󰖁"
else
    icon="󰖀"
fi

printf '%s %s%% #[fg=default]' "$icon" "$volume"
