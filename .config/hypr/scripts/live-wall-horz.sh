#!/bin/bash

# === CONFIG ===
MAIN_OUTPUTS="DP-4,HDMI-A-1"
BG_MAIN="$HOME/Pictures/backgrounds/fancyBackground.jpg"
FONT="JetBrainsMono-NFM-Regular"
OUTPUT_MAIN="/tmp/livewall-main.jpg"

# === METADATA ===
NCSPOT_TITLE=$(playerctl metadata title 2>/dev/null || echo "Nothing Playing")
NCSPOT_ARTIST=$(playerctl metadata artist 2>/dev/null || echo " ")

# === BUILD IMAGE ===
magick "$BG_MAIN" \
  -gravity South -pointsize 22 -font "$FONT" -fill white -annotate +0+100 "$NCSPOT_TITLE" \
  -gravity South -pointsize 18 -font "$FONT" -fill gray -annotate +0+70 "$NCSPOT_ARTIST" \
  "$OUTPUT_MAIN"

# === APPLY TO MAIN MONITORS ===
swww img "$OUTPUT_MAIN" --transition-type grow --transition-duration 2 --outputs "$MAIN_OUTPUTS"

