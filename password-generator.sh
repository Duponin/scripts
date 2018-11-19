#!/usr/bin/env bash

PWDIR=/tmp/password-generator
MXLEN=77

mkdir -p $PWDIR
cd $PWDIR
dd if=/dev/urandom of=raw bs=100K count=1 status=none
base64 raw > translated.txt

if [ -z "$1"  ]
then
    read -p "Enter password length desired: " PWLEN
    if [ -z "$PWLEN" ]
    then
        PWLEN=$MXLEN
    elif test $PWLEN -ge $MXLEN
    then
        PWLEN=$MXLEN
    else
        PWLEN=$((PWLEN+1))
    fi
else
    PWLEN=$1
    if test $PWLEN -ge $MXLEN
    then
        PWLEN=$MXLEN
    else
        PWLEN=$((PWLEN+1))
    fi
fi

cat translated.txt | colrm $PWLEN > translated-trimmed.txt

if [[ $2 ]]
then
    cat translated-trimmed.txt | head --lines=$2
else
    cat translated-trimmed.txt
fi

