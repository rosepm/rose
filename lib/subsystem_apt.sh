# apt subsystem
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

############################
# MAIN INTERFACES
############################
pm_show() {
  for i in "${PARAMETERS[@]}"
  do
    _apt "show $i"
  done
}

pm_search() {
  for i in "${PARAMETERS[@]}"
  do
    _apt "search $i"
  done
}

pm_install() {
  die "INSTALL NOT YET IMPLEMENTED FOR PACMAN!"
}
