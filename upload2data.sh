#!/usr/bin/env bash

DIST_DIR="/var/www/data.dupon.in/c"
DIST_MACHINE="data"
STD_URL="https://data.dupon.in/c/"
VERSION="0.1.1"
FILE="file"

sendFile()
{
    #scp $FILE $DIST_MACHINE:$DIST_DIR
    echo "$FILE $DIST_MACHINE:$DIST_DIR"
}

echoURL()
{
    printf "%b%b\n" "$STD_URL" "$FILE"
}

concatenate()
{
    if [[ $1 = "tar" || $1 = "t" ]]; then
        applyTar
    fi 
    if [[ $1 = "tgz" ]]; then
        applyTar
        applyGz
    fi
    if [[ $1 = "txz" ]]; then
        applyTar
        applyXz
    fi
    if [[ $1 = "zip" ]]; then
        applyZip
    fi
}

applyTar()
{
    FILE_OLD="$FILE"
    FILE="$(printf "$FILE%b\n" ".tar")"
    tar cvf $FILE $FILE_OLD
}

applyZip()
{
    FILE_OLD=$FILE
    FILE="$(printf "$FILE%b\n" ".zip")"
    zip -9  $FILE $FILE_OLD
}

applyGz()
{
    gzip -9 -m $FILE
    FILE="$(printf "$FILE%b\n" ".gz")"
}

applyXz()
{
    xz -9 $FILE
    FILE="$(printf "$FILE%b\n" ".xz")"
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

if [[ $1 = "--concatenate" || $1 = "-c" ]]; then
    FILE="$3"
    concatenate "$2"
    sendFile
fi

if [[ $1 = "--send" || $1 = "-s" ]]; then
    FILE="$2"
    sendFile
fi

if [[ $FILE != "file" ]]; then
    echoURL
fi

