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

import "common.sh"

PROGNAME=${0##*/}

usage_full()
{
  cat <<EOF
  Usage: $PROGNAME [OPTIONS] COMMAND [PACKAGES]

  Where COMMAND is one of the following:

    init            Initialize rose's initial configuration file

    search          Searches available packages

    show            Show information about an installed package

    install         Install a package (or packages)

    help            Print this help, or, if a command is provided, print that
                    command's help.

EOF
}

usage_init()
{
  cat <<EOF
  Usage: $PROGNAME [OPTIONS] init

    Create rose's initial configuration.

  OPTIONS:

    -v              Be verbose
    -f              Force a re-init
    -p=PATH         Use PATH as the location for rose's configuration file

  NOTES:

    * This will probably not leave your rose install in a useable state. It
      will give you a skeleton that is ready for you to modify.
    * Init will fail if a configuration is already found. Use '-f' to force
      a reinitialize.

EOF
}

usage_show()
{
  cat <<EOF
  Usage: $PROGNAME [OPTIONS] show PACKAGE(S)

    Show information about a package or packages.

  OPTIONS:

    -i              Show more information about a package.

  NOTES:

    * If no packages are listed, will show all installed packages.

EOF
}

usage_install()
{
  cat <<EOF
  Usage: $PROGNAME [OPTIONS] install PACKAGE(S)

    Install a package or packages on the system.

  OPTIONS:

    -v              Be verbose
    -y              Assume "yes" to all questions
EOF
}

usage_search() {
  cat <<EOF
  Usage: $PROGNAME search PACKAGE(S)

    Search for a package or packages.
EOF
}

############################
# MAIN ENTRY POINT
############################
usage() {
  local _no_command=0
  if [ -n "$CMD_INIT" ]; then
    usage_init
    _no_command=1
  fi

  if [ -n "$CMD_SHOW" ]; then
    usage_show
    _no_command=1
  fi

  if [ -n "$CMD_SEARCH" ]; then
    usage_search
    _no_command=1
  fi

  if [ -n "$CMD_INSTALL" ]; then
    usage_install
    _no_command=1
  fi

  if [ $_no_command -eq 0 ]; then
    usage_full
  fi
}
