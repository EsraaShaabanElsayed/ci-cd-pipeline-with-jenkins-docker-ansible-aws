#!/bin/bash

apt-get install python3-pip
pip3 install mysql-connector-python
pip3 install requests

python3 isON.py
# Check if application deployed
if [ $? -ne 0 ]; then
    echo "Error in isON.py. Stopping execution."
    exit 1  #
fi

python3 database.py
# Check the database behaviour
if [ $? -ne 0 ]; then
    echo "Error in database.py. Stopping execution."
    exit 1  
fi

echo "Test scripts executed successfully."

