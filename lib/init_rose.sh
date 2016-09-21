# rose initialization system
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

_print_header() {
  local d=$(date)
  cat << EOF > $CONF_FILE
# rose version $VERSION, file created '$d'
#
# This is the configuration file for rose. This file has been auto-
# generated. You should edit it to suit your needs.
#-----------------------------------------------------------------------

EOF
}

########################
# MAIN ENTRY POINT
########################
init_rose() {
  # -v verbose
  # -f force
  # PATHS may have install path
  set_config_file
  mkdir_conf_path

  if [ -f "$CONF_FILE" ]; then
    debug "Existing configuration file found!"
    if has_option "-f"; then
      local _tstamp=$(date "+%Y%m%d-%H%M%S")
      mv $CONF_FILE $CONF_FILE.$_tstamp
    else
      alert "Existing configuration file found, '$CONF_FILE'."
      die "Use '-f' to force overwriting configuration file..."
    fi
  fi

  debug "Creating configuration file '$CONF_FILE'..."
  touch $CONF_FILE

  debug "Printing header..."
  _print_header

}
