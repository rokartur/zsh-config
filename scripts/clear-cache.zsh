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
  # "/Users/artur/Library/Caches/com.spotify.client/Data"
  echo "Starting folder cleanup..."
  echo "Number of folders to process: ${#folders_to_delete[@]}"

  if command -v trash >/dev/null 2>&1; then
      for folder in "${folders_to_delete[@]}"; do
          if [[ -d "$folder" ]]; then
              echo "Moving to trash: $folder"
              trash "$folder"
          else
              echo "Folder does not exist: $folder"
          fi
      done
  else
      echo "No available tools to move to trash."
      echo "Install 'trash' with command: brew install trash"
      return 1
  fi

  echo "Folder cleanup completed!"
}
