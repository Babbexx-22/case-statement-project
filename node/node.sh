#!/bin/bash

PACKAGE_JSON_PATH="/home/ubuntu/node/package.json"

# Update and upgrade packages
sudo apt update && sudo apt upgrade -y
echo

# Install node.js,npm and pm2(a process manager)
echo "Installing node js, npm and pm2....."
sudo apt install nodejs -y
sudo apt install npm 
sudo npm install pm2 -g
echo

# Verify installation
node --version
npm --version
pm2 --version
echo

# Initialize the node js project and install express framework
npm init
npm install express -y
echo

# Using sed to modify the npm script to use pm2 as the nodejs process manager:
echo "Beginning substitution with sed command"
sed -i 's/"scripts": {/"scripts": {\n    "start": "pm2 start index.js",/' "$PACKAGE_JSON_PATH"

# Start the nodejs app
echo "starting the application...."
npm run start