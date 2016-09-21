# main configuration handling
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

# Set the config file, if parameter is passed, use that as path
set_config_file() {
  CONF_FILE=~/.roserc
  if [ $# -eq 0 ]; then
    if [ -n "$ROSECONF_PATH" ]; then
      CONF_FILE=$ROSECONF_PATH/.roserc
    else
      ROSECONF_PATH=~/
    fi
  else
    CONF_FILE=$*/.roserc
  fi
}

mkdir_conf_path() {
  debug "Making configuraion path '$ROSECONF_PATH'"
  mkdir -p $ROSECONF_PATH
}

load_config() {
  set_config_file
  . $CONF_FILE || die "Errot parsing configuration file!"
}
