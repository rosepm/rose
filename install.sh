#!/bin/bash

# rose install tool

unset LIBPATH BINPATH QUIET || true

# Shell color settings
COLOR_RESET='\e[0m'
COLOR_TRACE='\e[0;34m' # Blue
COLOR_WARNING='\e[1;33m' # Yellow
COLOR_ALERT='\e[4;31m' # Underline red
COLOR_DIE='\e[30m\033[41m' # Red background, black text

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

PROGNAME=${0##*/}

MY_CWD=`pwd`

usage()
{
  cat <<EOF
  Usage: $PROGNAME [OPTION]
  Where [OPTION] is one of the following:

  --lib=LIBPATH/        Installs the libraries to LIBPATH/

  --bin=BINPATH/        Installs the binary to BINPATH/

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
    *)
      usage 0
      shift
      ;;
  esac
done


