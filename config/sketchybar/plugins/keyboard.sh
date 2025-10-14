#!/usr/bin/env bash

SOURCE=$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleCurrentKeyboardLayoutInputSourceID)

case ${SOURCE} in
'com.apple.keylayout.US') LABEL='US' ;;
'com.apple.keylayout.ABC') LABEL='INT' ;;
'org.unknown.keylayout.US-CaT') LABEL='CaT' ;;
esac

sketchybar --set $NAME label="$LABEL"
