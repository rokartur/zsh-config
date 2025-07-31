if ! (( $+commands[eza] )); then
  print "zsh-eza-plugin: eza not found on path. Please install eza before using this plugin." >&2
  return 1
fi

alias ls='eza --hyperlink'
alias l='eza --long -bF'
alias ll='eza --long -a'
alias la='eza --hyperlink -a --group-directories-first --extended'
alias tree='eza --hyperlink --tree'

alias lT='eza --hyperlink --tree --long'
alias ld='eza --hyperlink --only-dirs'
alias lf='eza --hyperlink -a --only-files'
alias lC='eza --hyperlink --color-scale=size --long'
alias lsize='eza --hyperlink --long --sort=size'
alias lmod='eza --hyperlink --long --modified --sort=modified'

alias ldepth='eza --hyperlink --level=2'
alias lignore='eza --hyperlink --git-ignore'
alias lctx='eza --hyperlink --long --context'