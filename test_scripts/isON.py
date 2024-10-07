import requests

def check_website_status(url):
    try:
        response = requests.get(url)
        if response.status_code == 200:
            print(f'The website {url} is online.')
        else:
            print(f'The website {url} returned status code: {response.status_code}')
    except requests.exceptions.RequestException as e:
        print(f'The website {url} is offline or could not be reached. Error: {e}')

website_url = 'http://localhost:5050/petclinic'  
check_website_status(website_url)

