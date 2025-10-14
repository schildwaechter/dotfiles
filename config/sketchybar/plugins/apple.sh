#!/bin/bash

POPUP_OFF="sketchybar --set apple.logo popup.drawing=off"
POPUP_CLICK_SCRIPT="sketchybar --set \$NAME popup.drawing=toggle"

apple_logo=(
  icon=""
  icon.font="MesloLGS NF:Bold:16.0"
  icon.color="$COL_SKY"
  padding_right=15
  label.drawing=off
  click_script="$POPUP_CLICK_SCRIPT"
)

apple_about=(
  icon=""
  label="About This Mac"
  click_script="open x-apple.systempreferences:com.apple.SystemProfiler.AboutExtension; $POPUP_OFF"
)

apple_prefs=(
  icon=""
  label="Preferences"
  click_script="open -a 'System Preferences'; $POPUP_OFF"
)

apple_activity=(
  icon=""
  label="Activity"
  click_script="open -a 'Activity Monitor'; $POPUP_OFF"
)

apple_lock=(
  icon=""
  label="Lock Screen"
  click_script="pmset displaysleepnow; $POPUP_OFF"
)

apple_shutdown=(
  icon=""
  label="Shut Down…"
  click_script="osascript -e 'tell app \"loginwindow\" to «event aevtrsdn»'; $POPUP_OFF"
)

sketchybar --add item apple.logo left \
  --set apple.logo "${apple_logo[@]}" \
  \
  --add item apple.about popup.apple.logo \
  --set apple.about "${apple_about[@]}" \
  \
  --add item apple.prefs popup.apple.logo \
  --set apple.prefs "${apple_prefs[@]}" \
  \
  --add item apple.activity popup.apple.logo \
  --set apple.activity "${apple_activity[@]}" \
  \
  --add item apple.lock popup.apple.logo \
  --set apple.lock "${apple_lock[@]}" \
  \
  --add item apple.shutdown popup.apple.logo \
  --set apple.shutdown "${apple_shutdown[@]}"
