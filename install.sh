#!/bin/bash

# rose install tool

PROGNAME=${0##*/}

MY_CWD=`pwd`

usage()
{
    cat <<EOF
Usage: $PROGNAME [OPTION]
Where [OPTION] is one of the following
    --lib=LIBPATH/        Installs the libraries to LIBPATH/

    --bin=BINPATH/        Installs the binary to BINPATH/

If run with nothing, will install to user's home directory.
EOF
}

if [ "$1" = "" ]; then
    usage
    exit 0
fi

