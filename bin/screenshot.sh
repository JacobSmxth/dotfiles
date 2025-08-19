
#!/usr/bin/env bash
#
# screenshot.sh — grab a Wayland selection, annotate, and copy

set -euo pipefail

file="${XDG_RUNTIME_DIR:-/tmp}/shot.png"

# 1. capture
grim -g "$(slurp)" "$file"
# 2. annotate
swappy -f "$file"
# 3. copy
wl-copy
