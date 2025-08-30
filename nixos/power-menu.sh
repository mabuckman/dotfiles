#!/usr/bin/env bash

# Create temporary wofi config that disables input
TEMP_CONFIG=$(mktemp)
cat > "$TEMP_CONFIG" << EOF
width=200
height=160
location=center
show=dmenu
prompt=
filter_rate=100
allow_markup=false
no_actions=true
halign=fill
orientation=vertical
content_halign=fill
insensitive=false
allow_images=false
hide_scroll=true
dynamic_lines=false
matching=exact
parse_search=false
EOF

# Show power menu
choice=$(echo -e "Shutdown\nRestart\nLogout\nSleep" | wofi --conf="$TEMP_CONFIG" --style=/dev/null --css=<(cat << 'CSS'
window {
  margin: 0px;
  border: 2px solid #89b4fa;
  background-color: rgba(30, 30, 46, 0.95);
  border-radius: 12px;
}

#input {
  display: none;
}

#inner-box {
  margin: 5px;
  border: none;
  background-color: transparent;
}

#outer-box {
  margin: 5px;
  border: none;
  background-color: transparent;
}

#scroll {
  margin: 0px;
  border: none;
}

#text {
  margin: 5px;
  border: none;
  color: #cdd6f4;
  font-size: 13px;
}

#entry {
  border: none;
  border-radius: 8px;
  margin: 2px;
  padding: 8px;
  background-color: transparent;
}

#entry:selected {
  background-color: rgba(137, 180, 250, 0.3);
  border: 2px solid #89b4fa;
}

#entry:hover {
  background-color: rgba(49, 50, 68, 0.5);
}
CSS
))

# Clean up
rm "$TEMP_CONFIG"

# Execute choice
case "$choice" in
  "Shutdown") systemctl poweroff ;;
  "Restart") systemctl reboot ;;
  "Logout") hyprctl dispatch exit ;;
  "Sleep") systemctl suspend ;;
esac