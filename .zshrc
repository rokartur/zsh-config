source ~/.zsh/plugins/zsh-defer/zsh-defer.plugin.zsh

eval "$(starship init zsh)"

export STARSHIP_CONFIG=~/.zsh/starship/starship.toml
export STARSHIP_CACHE=~/.zsh/starship/cache
export FZF_DEFAULT_OPTS="
--border=none
--border-label-pos=bottom
--multi
--highlight-line
--wrap
--cycle
--ansi
--color=bg:#000000,fg:#e2e2e2
--color=hl:#646464,hl+:#e2e2e2
--color=fg+:#f1f1f1,bg+:#222222
--color=info:#00c4db,pointer:#ff8673,marker:#00d061,spinner:#8fa9ff,prompt:#d4a800,header:#ffffff
"

setopt auto_cd globdots inc_append_history share_history hist_ignore_dups hist_reduce_blanks

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_USE_ASYNC=true

# auto-completion settings 
zstyle ':completion:*' use-cache on
zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*:ignore-parents' ignore _
zstyle ':completion:*' insert-tab false
zstyle ':completion:*' menu select
zstyle ':completion:*:descriptions' format '[%d]'

zstyle ':fzf-tab:*' prefix ''
zstyle ':fzf-tab:*' show-group brief
zstyle ':fzf-tab:*' single-group color header
zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':fzf-tab' fzf-tab-completion yes
zstyle ':fzf-tab:*' fzf-command fzf
zstyle ':fzf-tab:*' continuous-trigger 'right'
zstyle ':fzf-tab:complete:*' hide-group-if-empty yes

zstyle ':fzf-tab:*' switch-group '[' ']'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --color=always --color-scale=all --color-scale-mode=fixed -1 $realpath 2>/dev/null | grep -vE "^\./\$|^\.\./\$" || echo "No preview available"'
zstyle ':fzf-tab:complete:nvim:*' fzf-preview 'bat --color=always --style=numbers $realpath 2>/dev/null || echo "No preview available"'
zstyle ':fzf-tab:complete:code:*' fzf-preview 'bat --color=always --style=numbers $realpath 2>/dev/null || echo "No preview available"'

export ZSH_DISABLE_COMPAUDIT=true
autoload -U compinit
compinit -u -C -d "$HOME/.cache/zcompdump"

source <(fzf --zsh)

source ~/.zsh/plugins/fzf-tab/fzf-tab.plugin.zsh

bindkey '^I' fzf-tab-complete # Tab key for fzf-tab completion
bindkey '^[[A' fzf-history-widget # Up arrow key for fzf history search

# aliases
zsh-defer source ~/.zsh/aliases/general.zsh
zsh-defer source ~/.zsh/aliases/eza.zsh

# plugins
zsh-defer source ~/.zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
zsh-defer source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
zsh-defer source ~/.zsh/plugins/zsh-httpie-request-manager/zsh-httpie-request-manager.plugin.zsh

# scripts
zsh-defer source ~/.zsh/scripts/update.zsh
zsh-defer source ~/.zsh/scripts/clear-cache.zsh

# homebrew
if [[ -z "$HOMEBREW_PREFIX" ]]; then
  zsh-defer eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# zoxide
if ! command -v __zoxide_z &> /dev/null; then
  zsh-defer eval "$(zoxide init zsh --cmd cd)"
fi

# bun
[ -s "$HOME/.bun/_bun" ] && zsh-defer source "$HOME/.bun/_bun"

# path
typeset -U path
path=(
  /opt/homebrew/bin
  /opt/homebrew/sbin
  /usr/bin
  /bin
  /usr/local/bin
  /usr/sbin
  /sbin
  /System/Cryptexes/App/usr/bin
  /var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin
  /var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin
  /var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin
  /Applications/Ghostty.app/Contents/MacOS
  $HOME/.bun/bin
  $HOME/.local/bin
)
export PATH
