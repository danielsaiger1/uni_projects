import requests
from bs4 import BeautifulSoup
import json

# with open('./output/data.json', 'r') as file:
#     data = json.load(file)

# # Funktion, um die Restauranttypen zu extrahieren
# def get_restaurant_types(url):
#     response = requests.get(url)
#     response.raise_for_status()  # Fehler für HTTP-Statuscodes behandeln
#     soup = BeautifulSoup(response.content, "html.parser")
#     restaurant_types = soup.find_all('input', {'type': 'checkbox', 'name': 'filter[cuisinetype][]'})
    
#     types = [
#         soup.find('label', {'for': elem.get('id')}).text.strip()
#         for elem in restaurant_types if elem.get('id')
#     ]
#     return types


# Aufruf der Funktion mit URL
url = "https://www.hamburg-tourism.de/shoppen-geniessen/restaurants-cafes/a-varina/"
subpage = requests.get(url)
soup = BeautifulSoup(subpage.text, "html.parser")

# Div mit der Klasse 'contact__address' finden
contact_address = soup.find('div', class_='contact__address')

# Alle 'divs' mit der Klasse 'contact__address__informationBundle' finden
info_bundles = contact_address.find_all('div', class_='contact__address__informationBundle')

# Erstes Bundle (für den Text)
if len(info_bundles) > 0:
    first_bundle = info_bundles[0]
    text_content = first_bundle.get_text(strip=True)
    if text_content:
        print("Text des ersten Bundles:", text_content)

# Zweites Bundle (für den Link)
if len(info_bundles) > 1:
    second_bundle = info_bundles[1]
    link = second_bundle.find('a')
    if link and 'href' in link.attrs:
        print("Link des zweiten Bundles:", link['href'])










def _get_location(subpage):
    soup = BeautifulSoup(subpage, "html.parser")
    location_div = soup.find_all('div', class_= "contact__adress")
    location = location_div.get_text(strip=True)
    return location

def _get_sublink(subpage):
    soup = BeautifulSoup(subpage, "hml.parser")
    location_div = soup.find_all('div', class_= "contact__adress")
    sublink = location_div.find('a')['href']
    return sublink
        

# location = _get_location(url) 
# sublink = _get_sublink(url)      
    
