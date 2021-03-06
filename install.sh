#!/bin/bash

# rose install tool
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

unset LIBPATH BINPATH QUIET UNINSTALL || true

# Shell color settings
COLOR_RESET='\033[0m'
COLOR_TRACE='\033[0;34m' # Blue
COLOR_WARNING='\033[1;33m' # Yellow
COLOR_ALERT='\033[4;31m' # Underline red
COLOR_DIE='\033[30m\033[41m' # Red background, black text

# Installation manifests
MANIFEST_LIB=(
'common.sh'
'output.sh'
'import.sh'
'usage.sh'
'init_rose.sh'
'config.sh'
'dispatcher.sh'
'subsystem_pacman.sh'
'subsystem_brew.sh'
'subsystem_apt.sh'
)

MANIFEST_BIN=(
'rose'
)

#######################
# HELPER FUNCTIONS
#######################

# Trace functions
inner_trace () {
  if [ -n "$LOG_FILE" ]; then
    echo -e "$(date) $*" >> ${LOG_FILE}
  else
    echo -e "$*"
  fi
}

warning () {
  if [ -n "$LOG_FILE" ]; then
    inner_trace "$*"
  else
    [ -n "$QUIET" ] || inner_trace "${COLOR_WARNING}$*${COLOR_RESET}"
  fi
}

trace () {
  if [ -n "$LOG_FILE" ]; then
    inner_trace "$*"
  else
    [ -n "$QUIET" ] || inner_trace "${COLOR_TRACE}$*${COLOR_RESET}"
  fi
}

alert() {
  if [ -n "$LOG_FILE" ]; then
    inner_trace "$*"
  else
    inner_trace "${COLOR_ALERT}$*${COLOR_RESET}"
  fi
}

die() {
  if [ -n "$LOG_FILE" ]; then
    inner_trace "$*"
  else
    inner_trace "${COLOR_DIE}$*${COLOR_RESET}"
  fi
  exit 1
}

# Installer functions
_remove() {
  if [ -f "$*" ]; then
    unlink $*
  else
    warning "Unable to unlink '$*'"
  fi
}

install_rose() {
  if [ -x "$LIBPATH/rose_install.sh" ]; then
    trace "Previous rose install found, uninstalling..."
    bash $LIBPATH/rose_install.sh --uninstall
  fi

  if [ ! -d "$BINPATH" ]; then
    mkdir -p $BINPATH
  fi

  if [ ! -d "$LIBPATH" ]; then
    mkdir -p $LIBPATH
  fi

  trace "Installing rose libraries..."
  for fn in "${MANIFEST_LIB[@]}"
  do
    cp -a lib/$fn $LIBPATH/$fn || alert "Cannot copy '$fn', was installer run from repo directory?"
  done

  trace "Installing rose binaries..."
  for fn in "${MANIFEST_BIN[@]}"
  do
    cp -a $fn $BINPATH/$fn || alert "Cannot copy '$fn', was installer run from repo directory?"
  done
  cp -a install.sh $LIBPATH/rose_install.sh || alert "Cannot copy installer,
  was it run from repo directory?"

  trace "Installation complete..."
  trace "Please make sure that '$BINPATH' is in your \$PATH, and that \$ROSELIB_PATH"
  trace "is set in your environment to '$LIBPATH'."
}

uninstall_rose() {
  trace "Removing rose libraries..."
  for fn in "${MANIFEST_LIB[@]}"
  do
    _remove "$LIBPATH/$fn"
  done

  trace "Removing rose binaries..."
  for fn in "${MANIFEST_BIN[@]}"
  do
    _remove "$BINPATH/$fn"
  done

  if [ -x "$LIBPATH/rose_install.sh" ]; then
    _remove "$LIBPATH/rose_install.sh"
  fi
}

#########################
# MAIN ENTRY POINT
#########################

PROGNAME=${0##*/}

usage()
{
  cat <<EOF
  Usage: $PROGNAME [OPTION]
  Where [OPTION] is one of the following:

  --lib=LIBPATH/        Installs the libraries to LIBPATH/

  --bin=BINPATH/        Installs the binary to BINPATH/

  --uninstall           Uninstall rose

  --quiet               Install quietly (ignored if LOGFILE used)

  --log=LOGFILE         Log installation to LOGFILE
                        (can also be set as environmental variable
                        "\$LOG_FILE")

  --help                Display this help message

  If run with nothing, will install to user's home directory.
EOF
}

for i in "$@"
do
  case $i in
    --lib=*)
      LIBPATH="${i#*=}"
      shift
      ;;
    --bin=*)
      BINPATH="${i#*=}"
      shift
      ;;
    -h|--help)
      usage
      exit 0
      shift
      ;;
    --quiet)
      QUIET=yes
      shift
      ;;
    --log=*)
      LOG_FILE="${i#*=}"
      shift
      ;;
    --uninstall)
      UNINSTALL=yes
      shift
      ;;
    *)
      usage 0
      exit 1
      shift
      ;;
  esac
done

[ -n "$LIBPATH" ] || LIBPATH=~/lib/rose
[ -n "$BINPATH" ] || BINPATH=~/bin

if [ -n "$UNINSTALL" ]; then
  trace "Uninstalling rose..."
  trace " "
  uninstall_rose

  trace "Done uninstalling"
  exit 0
fi

install_rose

