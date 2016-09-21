# usage library
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

PROGNAME=${0##*/}

usage_full()
{
  cat <<EOF
  Usage: $PROGNAME [OPTIONS] COMMAND [PACKAGES]

  Where COMMAND is one of the following:

    init            Initialize rose's initial configuration file

    search          Searches available packages

    help            Print this help, or, if a command is provided, print that
                    command's help.
EOF
}

usage_init()
{
  cat <<EOF
  Usage: $PROGNAME [OPTIONS] init
EOF
}

usage() {
  local _no_command=0
  if [ -n "$CMD_INIT" ]; then
    usage_init
    _no_command=1
  fi

  if [ $_no_command -eq 0 ]; then
    usage_full
  fi
}
