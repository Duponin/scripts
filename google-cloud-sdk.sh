#!/bin/bash
# Author : Antonin Dupont (Duponin@github)
# Latest update : 2018/05/25
#
# Source : (01-05) https://cloud.google.com/functions/docs/quickstart
# Source : (Linux) https://cloud.google.com/sdk/docs/#linux
#
# Side notes : It will not notice if there is a new version but the package can update itself while
#              installing. If Something is broken, notice me it on github.






# Pre-installation
echo ""
echo "#######################"
echo "#      WARNING !      #"
echo "#######################"
echo ""
echo "You must to place this script to the root of the place you want"
echo "to install the binaries. ( eg: ~/bin/ )"
echo ""
echo "Ctrl + C to cancel"
read -rsp $'Press any key to continue...\n' -n1 key


# Download payload and install it
wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-202.0.0-linux-x86_64.tar.gz
tar -xvf google-cloud-sdk-202.0.0-linux-x86_64.tar.gz
./google-cloud-sdk/install.sh
./google-cloud-sdk/bin/gcloud init

sleep 1

# Last step of the installation, without sourcing the shell config file
./google-cloud-sdk/bin/gcloud components update && ./google-cloud-sdk/bin/gcloud components install beta


# Ask if you want to delete temporary files
echo "Do you want to delete downloaded files etc. ? (Y/n)"
read input
if [ "$input" == "Y" ] || [ "$input" == "y" ]
then
	rm -rdf google-cloud-sdk-202.0.0-linux-x86_64.tar.gz && echo "tmp files deleted" && echo "Don't forget to reload your shell to activate you new PATH" && rm google-cloud-sdk.sh
else
	echo "Ok, exiting..." && exit
fi

