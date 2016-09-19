# Determine our OS and its flavor

if [ -f "/etc/debian_version" ]; then
  find_specific_debian
  IS_DEB=yes
elif [ -f "/etc/redhat-release" ]; then
  find_specific_redhat
  IS_RHEL=yes
elif [ -f "/etc/novell-release" ] || [ -f "/etc/SuSE-release" ]; then
  find_specific_suse
  IS_SLES=yes
elif [ -f "/etc/arch-release" ]; then
  find_specific_arch
  IS_ARCH=yes
elif [ -f "/etc/slackware-version" ]; then
  find_specific_slack
  IS_SLACK=yes
fi
