update() {
  local now
  local plugins_dir="${ZDOTDIR:-$HOME}/.zsh/plugins"

  local status_bun="fail"
  local status_zsh_plugins="fail"
  local status_homebrew="fail"

  print_header "bun"
  if command -v bun &>/dev/null; then
    if bun upgrade; then
      status_bun="ok"
    else
      status_bun="fail"
    fi
  else
    echo "bun not found"
    status_bun="fail"
  fi

  local total count repo name all_plugins_ok=1
  total=$(find "$plugins_dir" -maxdepth 1 -type d -exec test -d "{}/.git" \; -print | wc -l)
  
  if (( total == 0 )); then
    print_header "zsh plugins"
    echo "No git plugins found in $plugins_dir"
    status_zsh_plugins="fail"
    goto brew_update
  fi

  print_header "zsh plugins"
  count=0
  all_plugins_ok=1
  for repo in "$plugins_dir"/*; do
    if [[ -d "$repo/.git" ]]; then
      (( count++ ))
      name=$(basename "$repo")
      echo -e "\033[34mpulling...\033[0m  $name"
      
      if git -C "$repo" pull --ff-only --quiet; then
        echo -e "\033[32mup-to-date\033[0m  $name"
      else
        echo -e "\033[31merror updating\033[0m  $name"
        all_plugins_ok=0
      fi
    fi
  done

  if (( all_plugins_ok == 1 )); then
    status_zsh_plugins="ok"
  else
    status_zsh_plugins="fail"
  fi

  print_header "homebrew"
  if command -v brew &>/dev/null; then
    if brew update && brew upgrade && brew cleanup -s && brew doctor; then
      status_homebrew="ok"
    else
      status_homebrew="fail"
    fi
  else
    echo "homebrew not found"
    status_homebrew="fail"
  fi

  print_header "Summary"
  local green="\033[32mok\033[0m"
  local red="\033[31mfail\033[0m"

  echo "bun:           $([ "$status_bun" = "ok" ] && echo $green || echo $red)"
  echo "zsh plugins:   $([ "$status_zsh_plugins" = "ok" ] && echo $green || echo $red)"
  echo "homebrew:      $([ "$status_homebrew" = "ok" ] && echo $green || echo $red)"
  echo
}
