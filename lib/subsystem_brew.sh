# brew subsystem
#
# Copyright (C) 2016  Sam Hart
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

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
