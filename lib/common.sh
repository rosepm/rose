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

set -e

# Misc. helpers

unset IS_LINUX IS_BSD IS_SLES IS_SLACK IS_BSD IS_DEB IS_ARCH IS_RHEL || true
unset HAS_PAC HAS_APT HAS_APTITUDE HAS_DNF HAS_BREW || true

# Determines if an executable exists and is on path
exec_exists() {
  hash $* 2>/dev/null
}

# Determine our OS, its flavor, and what package managers we have
if exec_exists "uname"; then
  _uname=`uname`
  if [[ "$_uname" == 'Linux' ]]; then
    IS_LINUX=yes
  elif [[ "$_uname" == 'FreeBSD' ]]; then
    IS_BSD=yes
  fi
fi

if [ -f "/etc/debian_version" ]; then
  IS_DEB=yes
elif [ -f "/etc/redhat-release" ]; then
  IS_RHEL=yes
elif [ -f "/etc/novell-release" ] || [ -f "/etc/SuSE-release" ]; then
  IS_SLES=yes
elif [ -f "/etc/arch-release" ]; then
  IS_ARCH=yes
elif [ -f "/etc/slackware-version" ]; then
  IS_SLACK=yes
fi

if exec_exists "pacman"; then
  HAS_PAC=yes
fi

if exec_exists "apt-get"; then
  HAS_APT=yes
fi

