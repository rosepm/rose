#!/bin/bash

# rose install tool

unset LIBPATH BINPATH || true

PROGNAME=${0##*/}

MY_CWD=`pwd`

usage()
{
  cat <<EOF
  Usage: $PROGNAME [OPTION]
  Where [OPTION] is one of the following:

  --lib=LIBPATH/        Installs the libraries to LIBPATH/

  --bin=BINPATH/        Installs the binary to BINPATH/

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

