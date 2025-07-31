#/usr/bin/env zsh

clear-cache() {
  local folders_to_delete=(
      "$HOME/.bun/install"
      "$HOME/.npm"
      "$HOME/Movies/TV"
      "$HOME/Music/Music"
      "$HOME/Library/Application Support/discord/cache"
      "$HOME/Library/Application Support/Code/CachedExtensionVSIXs"
      "$HOME/Library/Application Support/Code/CachedData"
      "$HOME/Library/Application Support/Code/GPUCache"
      "$HOME/Library/Application Support/Code/Cache"
      "$HOME/Library/Caches/BraveSoftware"
      "$HOME/Library/Caches/Homebrew"
      "$HOME/Library/Application Support/discord/logs"
  )

  local green="\033[32m"
  local yellow="\033[33m"
  local red="\033[31m"
  local reset="\033[0m"

  print_header "Cache Cleanup"

  echo "${yellow}Starting folder cleanup...${reset}"
  echo "Number of folders to process: ${#folders_to_delete[@]}"

  if ! command -v trash >/dev/null 2>&1; then
    echo "${red}No available tools to move to trash.${reset}"
    echo "Install 'trash' with command: brew install trash"
    return 1
  fi

  local deleted_count=0
  local missing_count=0

  for folder in "${folders_to_delete[@]}"; do
    if [[ -d "$folder" ]]; then
      echo "Moving to trash: ${green}$folder${reset}"
      if trash "$folder"; then
        ((deleted_count++))
      else
        echo "${red}Failed to move to trash:${reset} $folder"
      fi
    else
      echo "Folder does not exist: ${yellow}$folder${reset}"
      ((missing_count++))
    fi
  done

  print_header "Summary"
  echo -e "Folders moved to trash: ${green}$deleted_count${reset}"
  echo -e "Folders not found: ${yellow}$missing_count${reset}"
  echo -e "Total folders processed: ${#folders_to_delete[@]}"

  echo
  echo "${green}Folder cleanup completed!${reset}"
}
