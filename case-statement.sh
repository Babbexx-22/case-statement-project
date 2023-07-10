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
b)
	echo "Running the apache script"
	./script.sh
    ;;
*) echo "You are only allowed to select from the above listed choices." ;;
esac