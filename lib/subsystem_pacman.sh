# pacman subsystem
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
_pacman() {
  if [ -n "$USE_SUDO" ]; then
    sudo pacman $*
  else
    pacman $*
  fi
}

##########################
# MAIN INTERFACES
##########################
pm_show() {
  local _p="-Q"
  if has_option "-i"; then
    _p="${_p}i"
  fi
  if [ "${#PARAMETERS[@]}" -eq 0 ]; then
    _pacman "$_p"
  else
    for i in "${PARAMETERS[@]}"
    do
      _pacman "$_p $i"
    done
  fi
}
