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

exec_exists "pacman" && HAS_PAC=yes
exec_exists "apt-get" && HAS_APT=yes
