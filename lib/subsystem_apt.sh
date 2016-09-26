# apt subsystem

import "common.sh"
import "output.sh"
import "config.sh"

unset _apt_exec || true

if [ -n "$APTITUDE_EXEC" ] && [ -n "$USE_APTITUDE" ]; then
  _apt_exec="$APTITUDE_EXEC"
elif [ -n "$APT_EXEC" ] && [ -n "$USE_APT" ]; then
  _apt_exec="$APT_EXEC"
fi

# Internal functions
_apt() {
  if [ -n "$_apt_exec" ]; then
    if [ -n "$USE_SUDO" ]; then
      sudo $_apt_exec $*
    else
      $_apt_exec $*
    fi
  else
    die "No apt executable set, is \$APT_EXEC set in the config file?"
  fi
}
