#!/usr/bin/env bash

DIST_DIR="/var/www/data.dupon.in/c"
DIST_MACHINE="data"
VERSION="0.1"
FILE="file"

sendFile()
{
    scp $FILE $DIST_MACHINE:$DIST_DIR
}

if [[ $1 = "--help" || $1 = "-h" ]]; then
    echo -e "upload2data [argument] [FILE]"
    echo -e ""
    echo -e "--help -h \t Show this help"
    echo -e "--send -s \t Send the file"
    echo -e "--tar -t \t Make a tarball before send (implicite -s)"
    echo -e "--version -v \t Show the current software version"
fi

if [[ $1 = "--version" || $1 = "-v" ]]; then
    printf "upload2data version: %b\n" "$VERSION"
fi

if [[ $1 = "--tar" || $1 = "-t" ]]; then
    tar cvf $2.tar $2
    FILE="$2.tar"
    sendFile
    rm -v $FILE
fi

if [[ $1 = "--send" || $1 = "-s" ]]; then
    FILE="$2"
    sendFile
fi

