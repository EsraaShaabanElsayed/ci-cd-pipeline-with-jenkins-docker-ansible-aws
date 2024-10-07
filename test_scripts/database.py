import requests
import mysql.connector
from mysql.connector import Error

# URL of the form
form_url = 'http://localhost:5050/petclinic/owners/new'

# Data to be filled in the form
data = {
    'firstName': 'bruce',
    'lastName': 'wayne',
    'address': 'email@example.com',
    'city': 'Cairo',
    'telephone': '12345',
    'submit': 'Submit'
}

session = requests.Session()
response = session.post(form_url, data=data)

if response.status_code == 200:
    print('Form submitted successfully!')

    # Database connection details
    try:
        connection = mysql.connector.connect(
            host='localhost',
            database='petclinic',  
            user='petclinic', 
            password='petclinic'  
        )

        if connection.is_connected():
            cursor = connection.cursor()
            query = "SELECT * FROM owners WHERE first_name = %s AND last_name = %s"
            cursor.execute(query, (data['firstName'], data['lastName']))
            result = cursor.fetchall()

            if result:
                print('Entry found in the database:', result)
                delete_query = "DELETE FROM owners WHERE first_name = %s AND last_name = %s"
                cursor.execute(delete_query, (data['firstName'], data['lastName']))
                connection.commit()  
                print('Entry removed from the database.')
            else:
                print('No entry found in the database.')

    except Error as e:
        print(f'Error connecting to MySQL: {e}')
    finally:
        if connection.is_connected():
            cursor.close()
            connection.close()
else:
    print(f'Failed to submit the form. Status code: {response.status_code}')

