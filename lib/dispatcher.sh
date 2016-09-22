# the command dispatcher
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

load_subsystem() {
  if [ -n "$USE_PAC" ] && [ -n "$HAS_PAC" ]; then
    import "subsystem_pacman.sh"
  elif [ -n "$USE_BREW" ] && [ -n "$HAS_BREW" ]; then
    import "subsystem_brew.sh"
  else
    die "Unable to load any subsystem, is your OS/package-manager supported?"
  fi
}

dispatcher() {
  load_config
  load_subsystem

  if [ -n "$CMD_SHOW" ]; then
    pm_show
  fi
}
