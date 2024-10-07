import requests
import mysql.connector

# URL of the form
form_url = 'http://localhost:5050/petclinic/owners/new'

# Data to be filled in the form
data = {
    'firstName': 'abcdef',
    'lastName': 'ghijklmnop',
    'address': 'email@example.com',
    'city': 'Cairo',
    'telephone': '12345',
    'submit': 'Submit'
}

# Create a session and submit the form
session = requests.Session()
response = session.post(form_url, data=data)

# Check if the form submission is successful
if response.status_code == 200:
    print('Form submitted successfully!')

    # Database connection details
    connection = mysql.connector.connect(
        host='localhost',
        database='petclinic',  
        user='petclinic',  
        password='petclinic'  
    )

    if connection.is_connected():
        cursor = connection.cursor()
        # Query to check if the entry exists
        query = "SELECT * FROM owners WHERE first_name = %s AND last_name = %s"
        cursor.execute(query, (data['firstName'], data['lastName']))
        result = cursor.fetchall()

        # If the entry is found, delete it
        if result:
            print('Entry found in the database:', result)
            delete_query = "DELETE FROM owners WHERE first_name = %s AND last_name = %s"
            cursor.execute(delete_query, (data['firstName'], data['lastName']))
            connection.commit()  # Commit the changes
            print('Entry removed from the database.')
        else:
            print('No entry found in the database.')

        cursor.close()
        connection.close()
else:
    print(f'Failed to submit the form. Status code: {response.status_code}')
