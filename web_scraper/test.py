import requests
from bs4 import BeautifulSoup
import json

with open('./output/data.json', 'r') as file:
    data = json.load(file)

# Funktion, um die Restauranttypen zu extrahieren
def get_restaurant_types(url):
    response = requests.get(url)
    response.raise_for_status()  # Fehler für HTTP-Statuscodes behandeln
    soup = BeautifulSoup(response.content, "html.parser")
    restaurant_types = soup.find_all('input', {'type': 'checkbox', 'name': 'filter[cuisinetype][]'})
    
    types = [
        soup.find('label', {'for': elem.get('id')}).text.strip()
        for elem in restaurant_types if elem.get('id')
    ]
    return types
    
# Aufruf der Funktion mit URL
url = "https://www.hamburg-tourism.de/shoppen-geniessen/restaurants-cafes/restaurants-von-a-bis-z/"
restaurant_types = get_restaurant_types(url)



for key in data.keys():
    data[key]['cuisine_type'] = [
        i for i in data[key]['features'] if i in restaurant_types
    ]
    for i in data[key]['features']:
        if i in ['Restaurant', 'Café/Bistro']:
            data[key]['type'] = i
            break
        else:
            data[key]['type'] = 'N/A'

print(data['Bacana'])            


    
