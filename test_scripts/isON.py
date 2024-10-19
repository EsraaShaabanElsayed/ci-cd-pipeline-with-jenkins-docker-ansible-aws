import requests

website_url = 'http://localhost:5050'
response = requests.get(website_url)
print(f'The website {website_url} is online with status code: {response.status_code}')
