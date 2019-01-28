# SCRIPTS

## GOAL

I put in this repo my scripts. It can be useful like useless.

`WARNING!` Always refer to help command inside scripts, this man page may not be up to date!

## Your code is ugly!

1. Fork it
2. Fix it
3. Pull request it

But you can also:

1. harder
2. better
3. faster
4. stronger

More seriously, yes it can be awful and have issues but I want my code to work. I'm not targeting to be the best and to have the perfect code.

## Explanation & tips

### google-cloud-sdk.sh (V. 0.1)

Script to install google cloud sdk &Cie. Probably out of date. You may need to change the package version in the downloader etc.

### password-generator.sh (V 0.1)

Script to generate a password using only built-in command. Light weight and probably not secure, processed files are stored in /tmp (changeable with a VAR in the script header).\
It accepts 2 arguments:
- $1 is the number of character you want (MAX=77)
- $2 is the quantity of password you want (MAX=18)

If no argument is provided, after the genaration, it only asks for $1.\
If argument is greater or equal 0, it takes the MAX value.

### upload2data (V 0.1.1)

Pseudo minimalist script to send files to machine over SSH. You will need to have a SSH config file.

Change the var DIST\_MACHINE according to the machine you want to upload.\
Change the var DIST\_DIR according to the location you want to place the file.\
Change teh var STP\_URL to the base URL of your server.

A help is provided with the `--help` or `-h` flag.

| Argument         | Description                                                         |
|:-----------------|:--------------------------------------------------------------------|
| `--help` `-h`    | To have some help                                                   |
| `--tar` `-t`     | To make a tarball before the shipment (removed after the send)      |
| `--send` `-s`    | Mandatory if you want to send a file without a tar or anything else |
| `--version` `-v` | To display the current version of the software                      |

#### Todo (upload2data)

* ~~Better display (into an array)~~
* Verify is the file is alread present on the server (associated with --force argument)
* Sanitize filename (with argument, or for tarball)
* ~~Output data's URL~~
* ~~Compress the tarball~~
    * ~~Zip~~
    * ~~Gz~~
    * ~~xz~~
* ~~Zip a directory for better compatibility~~
* Better argument handle

