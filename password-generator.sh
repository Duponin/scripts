#! /bin/env bash

PWDIR=/tmp/password-generator
MXLEN=77

mkdir -p $PWDIR
cd $PWDIR
dd if=/dev/urandom of=raw bs=1K count=1 status=none
base64 raw > translated.txt
read -p "Enter password lenght desired: " PWLEN
if test $PWLEN -ge $MXLEN
then
    PWLEN=$MXLEN
else
    PWLEN=$((PWLEN+1))
fi
cat translated.txt | colrm $PWLEN > translated-trimmed.txt
cat translated-trimmed.txt
