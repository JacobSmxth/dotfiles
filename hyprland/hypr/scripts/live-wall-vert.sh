#!/bin/bash

# === CONFIG ===
VERT_OUTPUT="DP-5"
BG_VERT="$HOME/Pictures/backgrounds/vertFancyBG.jpg"
OUTPUT_VERT="/tmp/livewall-vert.jpg"
FONT="/usr/share/fonts/TTF/JetBrainsMonoNerdFont-Bold.ttf"

# === METADATA ===
# Date & time
DATE=$(date "+%A, %B %d")
TIME=$(date "+%I:%M %p")

# Weather: condition + temp in Fahrenheit
RAW_CONDITION=$(curl -s "wttr.in/Cumming?format=%C")
RAW_TEMP_C=$(curl -s "wttr.in/Cumming?format=%t" | grep -o '[0-9]\+')
TEMP_F=$(awk "BEGIN { printf(\"%.0f\", ($RAW_TEMP_C * 9/5) + 32) }")
WEATHER="Cloudy"
[[ -n "$RAW_CONDITION" ]] && WEATHER="$RAW_CONDITION"
WEATHER_DISPLAY="${WEATHER}, ${TEMP_F}°F"

# === BUILD IMAGE ===
magick "$BG_VERT" \
  -resize 1440x2560^ -gravity center -extent 1440x2560 \
  -font "$FONT" -fill white \
  -pointsize 44 -gravity North -annotate +0+120 "$DATE\n$TIME\n$WEATHER_DISPLAY" \
  "$OUTPUT_VERT"

# === APPLY WALLPAPER ===
swww img "$OUTPUT_VERT" --transition-type grow --transition-duration 2 --outputs "$VERT_OUTPUT"

