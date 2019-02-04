#!/usr/bin/env bash

source lib/config.shlib

# Do not edit those variables, it will be overwrited
# It's declarated here to be global variables
DIST_DIR=""
DIST_MACHINE=""
STD_URL=""
VERSION=""
FILE=""

CONFIG_FILE="config.cfg"
CONFIG_FILE_DEFAULT="config.cfg.default"

loadConfig ()
{
    DIST_DIR=$(config_get UPLOAD2DATA_DIST_DIR)
    DIST_MACHINE=$(config_get UPLOAD2DATA_DIST_MACHINE)
    STD_URL=$(config_get UPLOAD2DATA_STD_URL)
    VERSION=$(config_get UPLOAD2DATA_VERSION)
    FILE=$(config_get UPLOAD2DATA_FILE)
}

sendFile()
{
    scp $FILE $DIST_MACHINE:$DIST_DIR
}

echoURL()
{
    printf "%b%b\n" "$STD_URL" "$FILE"
}

concatenate()
{
    if [[ $1 = "tar" || $1 = "t" ]]; then
        applyTar
    elif [[ $1 = "tgz" ]]; then
        applyTar
        applyGz
    elif [[ $1 = "txz" ]]; then
        applyTar
        applyXz
    elif [[ $1 = "zip" ]]; then
        applyZip
    else
        echo "Format unsupported."
        exit 1
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
    zip -9 -v  $FILE $FILE_OLD
}

applyGz()
{
    gzip -9 -v -m $FILE
    FILE="$(printf "$FILE%b\n" ".gz")"
}

applyXz()
{
    xz -9 -v $FILE
    FILE="$(printf "$FILE%b\n" ".xz")"
}

if [[ ! -f config.cfg ]]; then
    echo "Config file missing!"
    echo -e "Do \e[32m'cp config.cfg.default config.cfg'\e[0m and edit according to your need."
    exit 1
else
    loadConfig
fi

if [[ $1 = "--help" || $1 = "-h" ]]; then
    echo -e "upload2data [argument] [FILE]"
    echo -e ""
    echo -e "-h --help \t Show this help"
    echo -e "-s --send \t Send the file"
    echo -e "-c --concatenate Bundle the file/folder (option: tar tgz txz zip)"
    echo -e "-v --version \t Show the current software version"

elif [[ $1 = "--version" || $1 = "-v" ]]; then
    printf "upload2data version: %b\n" "$VERSION"

elif [[ $1 = "--concatenate" || $1 = "-c" ]]; then
    FILE="$3"
    concatenate "$2"
    sendFile

elif [[ $1 = "--send" || $1 = "-s" ]]; then
    FILE="$2"
    sendFile

else
    echo "Option not recognized."
    exit 1
fi

if [[ $FILE != "file" ]]; then
    echoURL
fi

