(( ${+commands[steampipe]} || ${+commands[asdf]} && ${+functions[_direnv_hook]} )) && () {

  local command=${commands[steampipe]:-"$(${commands[asdf]} which steampipe 2> /dev/null)"}
  [[ -z $command ]] && return 1

  local compfile=$1/functions/_steampipe
  if [[ ! -e $compfile || $compfile -ot $command ]]; then
    $command completion zsh >| $compfile
    print -u2 -PR "* Detected a new version 'steampipe'. Regenerated completions."
  fi
} ${0:h}
