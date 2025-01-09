import requests
from bs4 import BeautifulSoup
from typing import Dict

HEADERS = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3"
}

#selenium nutzen um gesamte liste zu laden



page_url = "https://www.hamburg-tourism.de/shoppen-geniessen/restaurants-cafes/restaurants-von-a-bis-z/"
page = requests.get(page_url, headers=HEADERS)

soup = BeautifulSoup(page.content, "html.parser")

listings = soup.find_all("article", class_="listTeaser")


restaurants: Dict[str, Dict] = {}

for article in listings:
    name = article.find('h3').text.strip()
    description = article.find('p').text.strip()
    link = f"https://www.hamburg-tourism.de{article.find('a')['href']}"
    type = []

    ul = article.find('ul')  
    if ul:
        list_items = ul.find_all('li')
    for li in list_items:
        type.append(li.text.strip())
        
    restaurants[name] = {}
    restaurants[name]['description'] = description
    restaurants[name]['link'] = link
    restaurants[name]['type'] = type


print(restaurants['Alsterkrug'])




#restaurants = {'restaurant_name': {'type': 'Italian', 'description': 'Italian food', 'link': 'link_placeholder', 'location': 'adress_placeholder'}, 
#               'restaurant_name2': {'type': 'Italian', 'description': 'Italian food', 'link': 'link_placeholder', 'location': 'adress_placeholder'}}