source ~/.zsh/plugins/zsh-defer/zsh-defer.plugin.zsh

eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.zsh/starship/starship.toml
export STARSHIP_CACHE=~/.zsh/starship/cache

setopt auto_cd globdots share_history hist_ignore_dups hist_reduce_blanks extended_history

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_USE_ASYNC=true
ZSH_TAB_TITLE_ENABLE_FULL_COMMAND=true
ZSH_TAB_TITLE_DEFAULT_DISABLE_PREFIX=true
FZF_DEFAULT_OPTS="
--style=minimal
--multi
--highlight-line
--wrap
--cycle
--color=bg:#000000,fg:#e2e2e2
--color=hl:#00d061,hl+:#e2e2e2
--color=fg+:#f1f1f1,bg+:#222222
--color=info:#00c4db,pointer:#ff8673,marker:#00d061,spinner:#8fa9ff,prompt:#d4a800,header:#ffffff
"

# autocomplete settings 
export ZSH_DISABLE_COMPAUDIT=true
zsh-defer autoload -U compinit
zsh-defer compinit -u -C -d "$HOME/.cache/zcompdump"

zstyle ':completion:*' use-cache on
zstyle ':completion:*' insert-tab false
zstyle ':completion:*' menu select=long
zstyle ':completion:*' list-packed true
zstyle ':completion:*' list-rows-first true

zstyle ':autocomplete:menu-select:*' wrap false
zstyle ':autocomplete:*complete*:*' insert-unambiguous yes
zstyle ':autocomplete:*history*:*' insert-unambiguous yes
zstyle ':autocomplete:*:*' list-lines 'reply=( $(( LINES )) )'

source /opt/homebrew/opt/fzf/shell/key-bindings.zsh

# aliases
zsh-defer source ~/.zsh/aliases/general.zsh
zsh-defer source ~/.zsh/aliases/eza.zsh

# plugins
source ~/.zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh
zsh-defer source ~/.zsh/plugins/zsh-tab-title/zsh-tab-title.plugin.zsh
zsh-defer source ~/.zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
zsh-defer source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh

# scripts
zsh-defer source ~/.zsh/scripts/print-header.zsh
zsh-defer source ~/.zsh/scripts/update.zsh
zsh-defer source ~/.zsh/scripts/clear-cache.zsh

zsh-defer bindkey '^[[A' fzf-history-widget
zsh-defer bindkey '^R' fzf-history-widget

# homebrew
[[ -z "$HOMEBREW_PREFIX" ]] && zsh-defer eval "$(/opt/homebrew/bin/brew shellenv)"

# zoxide
if ! command -v __zoxide_z &> /dev/null; then
  zsh-defer eval "$(zoxide init zsh --cmd cd)"
fi

# bun
zsh-defer [ -s "$HOME/.bun/_bun" ] && zsh-defer source "$HOME/.bun/_bun"

# path
zsh-defer typeset -U path
path=(
  /opt/homebrew/bin
  /opt/homebrew/sbin
  /usr/bin
  /bin
  /usr/local/bin
  /usr/sbin
  /sbin
  /System/Cryptexes/App/usr/bin
  $HOME/.bun/bin
  $HOME/.local/bin
)
