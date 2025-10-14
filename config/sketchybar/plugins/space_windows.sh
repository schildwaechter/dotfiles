#!/usr/bin/env bash

if [ "$SENDER" = "space_windows_change" ]; then

  source "$CONFIG_DIR/plugins/icon_map.sh"

  for sid in $(aerospace list-workspaces --all); do
    spaceapps="$(aerospace list-windows --workspace "$sid" --json | jq -r '[.[] | ."app-name"] | unique | .[]')"

    icon_strip=" "
    if [ "${spaceapps}" != "" ]; then
      while read -r app; do
        __icon_map "$app"
        icon_strip+="${icon_result}"
      done <<<"${spaceapps}"
    else
      icon_strip=" —"
    fi

    sketchybar --set space.$sid label="$icon_strip"
    echo "$spaceapps" >"/tmp/space.apps.$sid"
    echo "$icon_strip" >"/tmp/space.strip.$sid"
  done
fi
