import requests
import mysql.connector

# URL of the form
form_url = 'http://localhost:5050/petclinic/owners/new'

# Data to be filled in the form
data = {
    'firstName': 'abcdefgh',
    'lastName': 'ijklmnop',
    'address': 'email@example.com',
    'city': 'Cairo',
    'telephone': '12345',
    'submit': 'Submit'
}

# Create a session and submit the form
session = requests.Session()
response = session.post(form_url, data=data)

print('Form submitted successfully!')

# Database connection details
connection = mysql.connector.connect(
    host='localhost',
    database='petclinic',
    user='petclinic',
    password='petclinic'
)

# Create a cursor object
cursor = connection.cursor()

# Query to check if the entry exists
query = "SELECT * FROM owners WHERE first_name = %s AND last_name = %s"
cursor.execute(query, (data['firstName'], data['lastName']))

# Fetch all matching results
result = cursor.fetchall()

# Delete the entry
print('Entry found in the database:', result)
delete_query = "DELETE FROM owners WHERE first_name = %s AND last_name = %s"
cursor.execute(delete_query, (data['firstName'], data['lastName']))

# Commit the changes to remove the entry
connection.commit()
print('Entry removed from the database.')

# Close cursor and connection
cursor.close()
connection.close()
