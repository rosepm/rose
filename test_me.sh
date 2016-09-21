#!/bin/bash

. $ROSELIB_PATH/import.sh

import "common.sh"
import "output.sh"
import "usage.sh"

# Test a bunch of imports
import "common.sh"
import "common.sh"
import "common.sh"
import "common.sh"
import "common.sh"
import "usage.sh"
import "usage.sh"
import "usage.sh"

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

dump_imports
