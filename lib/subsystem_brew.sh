# brew subsystem

import "common.sh"
import "output.sh"
import "config.sh"

# Internal functions
_brew() {
  if [ -n "$BREW_EXEC" ]; then
    if [ -n "$USE_SUDO" ]; then
      sudo $BREW_EXEC $*
    else
      $BREW_EXEC $*
    fi
  else
    die "No brew executable set, is \$BREW_EXEC set in the config file?"
  fi
}

###########################
# MAIN INTERFACES
###########################
pm_show() {
  local _c="desc"
  if has_option "-i"; then
    _c="info"
  fi
  for i in "${PARAMETERS[@]}"
  do
    _brew "$_c $i"
  done
}
