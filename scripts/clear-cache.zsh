#/usr/bin/env zsh

clear_cache() {
  local folders_to_delete=(
      "/Users/artur/.bun/install"
      "/Users/artur/.npm"
      "/Users/artur/Movies/TV"
      "/Users/artur/Music/Music"
      "/Users/artur/Library/Application Support/discord/cache"
      "/Users/artur/Library/Application Support/Code/CachedExtensionVSIXs"
      "/Users/artur/Library/Application Support/Code/CachedData"
      "/Users/artur/Library/Application Support/Code/GPUCache"
      "/Users/artur/Library/Application Support/Code/Cache"
      "/Users/artur/Library/Caches/BraveSoftware"
      "/Users/artur/Library/Caches/Homebrew"
      "/Users/artur/Library/Application Support/discord/logs"
      "/Users/artur/Library/Caches/com.spotify.client/Data"
  )
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
