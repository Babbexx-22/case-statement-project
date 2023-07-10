#!/bin/bash

# Installing Dependencies

echo "Installing Packages"
echo "################################################"
sudo apt update && sudo apt install wget unzip apache2 -y > /dev/null
echo 

# Start & Enable Services

echo "Start & Enable Services"
echo "################################################"

sudo systemctl start apache2
sudo systemctl enable apache2
echo

#Creating a Temp Directory

echo "Start Artifact Deployment"
echo "################################################"

mkdir -p /tmp/webfiles
cd /tmp/webfiles
echo

wget https://www.tooplate.com/zip-templates/2098_health.zip > /dev/null
unzip 2098_health.zip
sudo cp -r 2098_health/* /var/www/html/

#Bounce Service

echo "Restarting apache2 Service"
echo "################################################"

sudo systemctl restart apache2
echo

#Clean up

echo "Removing Temporary Files"
echo "################################################"

rm -rf /tmp/webfiles

sudo systemctl status apache2
ls -l /var/www/html/