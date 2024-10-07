#!/bin/bash

apt-get install python3-pip
pip3 install mysql-connector-python
pip3 install requests

# Run the first Python script
python3 database.py
# Check the exit status of the first script
if [ $? -ne 0 ]; then
    echo "Error in database.py. Stopping execution."
    exit 1  # Exit the script with an error code
fi

# Run the second Python script
python3 isON.py
# Check the exit status of the second script
if [ $? -ne 0 ]; then
    echo "Error in isON.py. Stopping execution."
    exit 1  # Exit the script with an error code
fi

echo "Both scripts executed successfully."

