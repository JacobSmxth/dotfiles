#!/bin/bash

# === CONFIG ===
MAIN_MONITOR="DP-4"
VERT_MONITOR="DP-5"

BG_MAIN="$HOME/Pictures/backgrounds/fancyBackground.jpg"
BG_VERT="$HOME/Pictures/backgrounds/vertFancyBG.jpg"

FONT="JetBrainsMono-NFM-Regular"

OUTPUT_MAIN="/tmp/livewall-main.png"
OUTPUT_VERT="/tmp/livewall-vert.png"

# === METADATA ===
NCSPOT_TITLE=$(playerctl metadata title 2>/dev/null || echo "Nothing Playing")
NCSPOT_ARTIST=$(playerctl metadata artist 2>/dev/null || echo " ")

WEATHER=$(curl -s 'wttr.in/?format=1')
TIME=$(date "+%I:%M %p")
DATE=$(date "+%A, %B %d")

# === BUILD MAIN MONITOR IMAGE ===
magick "$BG_MAIN" \
  -gravity South -pointsize 22 -font "$FONT" -fill white -annotate +0+100 "$NCSPOT_TITLE" \
  -gravity South -pointsize 18 -font "$FONT" -fill gray -annotate +0+70 "$NCSPOT_ARTIST" \
  "$OUTPUT_MAIN"

# === BUILD VERTICAL MONITOR IMAGE ===
magick "$BG_VERT" \
  -resize 1440x2560^ -gravity center -extent 1440x2560 \
  -gravity North -pointsize 24 -font "$FONT" -fill white -annotate +0+180 "$DATE\n$TIME\n$WEATHER" \
  "$OUTPUT_VERT"

# === APPLY PER MONITOR ===
swww img "$OUTPUT_MAIN" --transition-type grow --transition-duration 2 --outputs "$MAIN_MONITOR"
swww img "$OUTPUT_VERT" --transition-type grow --transition-duration 2 --outputs "$VERT_MONITOR"

