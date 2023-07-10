--------------------------------------------------------
## UTILIZING CASE STATEMENT IN DEPLOYING TWO WEB APPLICATIONS; A NODE.JS APP AND APACHE WEB APP.
The apache web app script that was used was gotten from the github repository of "y2o-dev", a member of the "DevOps Trio" Study Group!!!

--------------------------------------------------------
## PREREQUISITES:

- AWS Account
- Ubuntu Based EC2 instance
- Edit the inbound rule of the instance to allow ssh traffic from port "22", http from port "80" and a custom TCP from port "3000" for the node js application.


--------------------------------------------------------

## STEP 1: Create a file "apache-web-app.sh" and populate it with the following content

```
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

```
The above script will download the application file, unzip it and copy it to the web root directory "/var/www/html" after which the apache service is restarted.

--------------------------------------------------------


--------------------------------------------------------

## STEP 2: PREPARING THE NODE JS FILES

- Create a directory "node". The directory contains an index.js file and a "public" folder which houses the index.html file.

- Populate the index.js file with the content below:

```
const express = require('express');
const app = express();
const port = 3000;

// Serve static files from the 'public' folder
app.use(express.static('public'));

app.get('/', (req, res) => {
  res.send('Hello, world!');
});

// app.listen(port, () => {
//   console.log(`App listening at http://localhost:${port}`);
// });

app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});

```
and the "index.html" file within the public folder with;

```
<!DOCTYPE html>
<html>
<head>
  <title>My Node.js App</title>
</head>
<body>
  <h1>Welcome to my Node.js app!</h1>
  <p>This is a simple node.js app with which I practised case-statement.</p>
</body>
</html>


```

--------------------------------------------------------

![tree node](https://github.com/Babbexx-22/case-statement-project/assets/114196715/9bd12cce-c380-4981-b08f-1596315bb2c1)

- In the same node directory, create your "node.sh" file (and make it executable using ` chmod a+x node.sh `). This file contains the concatenated commands to set up your node.js application.

```
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

```

--------------------------------------------------------

## STEP 3: Create the case statement script.

- Create a "case-statement.sh" file. This script will be executed to deploy your node.js application and apache web app.

- Make the script executable by changing file permissions; ` chmod +x case-statement.sh `

- Here's my case statement script ;

```
read -p "Hi, Welcome to meempharm Hub! Your name please: " Name

echo "
Hi "${Name}, which web application would you like to deploy?"

1) Node.js
2) Apache
"
read -r answer
case $answer in
1)
	echo " Change directory to node and run the script"
	cd /home/ubuntu/node && ./node.sh
    ;;
2)
	echo "Running the apache script"
	./script.sh
    ;;
*) echo "You are only allowed to select from the above listed choices." ;;
esac

```

--------------------------------------------------------

## STEP 4: Run the "case-statement.sh" script with `./case-statement.sh`


## THREE SCENARIOS BASED ON THE SELECTED CHOICES.


## FIRST SCENARIO: If "1" is selected,

![beggining of script](https://github.com/Babbexx-22/case-statement-project/assets/114196715/e006ca46-96ed-43ec-917e-e24f11bddd51)

--------------------------------------------------------

The script changes directory to the node directory and the "node.sh" script therein is executed.

Within the node.sh script, sed command was used to insert a start script which allows pm2 to start the node.js app in the background.

Shown below, pm2 successfully started the node.js application.

--------------------------------------------------------

![pm2 started node](https://github.com/Babbexx-22/case-statement-project/assets/114196715/f836dfe8-d392-4877-bc6f-fd016809bc98)

--------------------------------------------------------


The node.js app as shown in the web browser; 

--------------------------------------------------------

![node app](https://github.com/Babbexx-22/case-statement-project/assets/114196715/daa0e318-15ea-4d2b-b063-5b30790e57e7)

--------------------------------------------------------

## SECOND SCENARIO: If "2" is selected. The apache-web-app.sh script is executed.

![beg of script 2](https://github.com/Babbexx-22/case-statement-project/assets/114196715/ef581dbc-a70a-4158-80dd-125497c14c7b)

--------------------------------------------------------

The apache web app is as shown;

![apache web app content](https://github.com/Babbexx-22/case-statement-project/assets/114196715/cf4af8ea-2ba9-4777-94ed-d2fd123af380)


--------------------------------------------------------

## THIRD SCENARIO: If any other input was supplied apart from "1" or "2", a custom message is served.

![beg of script 3](https://github.com/Babbexx-22/case-statement-project/assets/114196715/d508e813-3bef-4784-a6ec-07566bb974c1)


---------------------------------------------------------

		THE END

---------------------------------------------------------
