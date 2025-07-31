#!/usr/bin/env zsh

print_header() {
  local line_width=70
  local now name text_len dash_count dashes
  now=$(date +"%H:%M:%S")
  name="$1"
  text_len=$(( ${#now} + 3 + ${#name} )) # "── $now ─ $name"
  dash_count=$(( line_width - text_len ))
  if (( dash_count < 0 )); then
    dash_count=0
  fi
  dashes=$(printf '─%.0s' $(seq 1 $dash_count))
  echo -e "\n── $now ─ $name $dashes"
}
