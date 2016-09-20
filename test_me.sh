#!/bin/bash

. $ROSELIB_PATH/common.sh || echo "ERROR! Unable to load rose libraries!"

if [ -n "$IS_LINUX" ]; then
  echo "IS LINUX"
fi

if [ -n "$IS_ARCH" ]; then
  echo "IS ARCH"
fi

if [ -n "$HAS_PAC" ]; then
  echo "HAS PACMAN"
fi

if [ -n "$HAS_APT" ]; then
  echo "FOUND APT"
fi
