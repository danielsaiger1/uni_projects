from bs4 import BeautifulSoup
from typing import Dict
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC


URL = "https://www.hamburg-tourism.de/shoppen-geniessen/restaurants-cafes/restaurants-von-a-bis-z/"

chrome_options = webdriver.ChromeOptions()
driver = webdriver.Chrome(options = chrome_options)

driver.get(URL)

button = driver.find_element(By.CSS_SELECTOR, '[data-testid="uc-accept-all-button"]')
driver.execute_script("arguments[0].click();", button)


expand_teaser = driver.find_element(By.XPATH, "//a[contains(@class, 'readMore__link')]")

# Scrolle das Element in den Sichtbereich
driver.execute_script("arguments[0].scrollIntoView(true);", expand_teaser)

expand_teaser.click()

page = driver.page_source

#selenium nutzen um gesamte liste zu laden
#Küchenstile etc. auslesen, um erkennung zu ermöglichen


soup = BeautifulSoup(page, "html.parser")

teaser_list = soup.find("div", class_="teaserList-inline__page")

listings = teaser_list.find_all("article", class_="listTeaser")


restaurants: Dict[str, Dict] = {}

for article in listings:
    name = article.find('h3').text.strip()
    description = article.find('p').text.strip()
    link = f"https://www.hamburg-tourism.de{article.find('a')['href']}"
    features = []

    ul = article.find('ul')  
    if ul:
        list_items = ul.find_all('li')
    for li in list_items:
        features.append(li.text.strip())
        
    restaurants[name] = {}
    restaurants[name]['description'] = description
    restaurants[name]['link'] = link
    restaurants[name]['features'] = features


print(restaurants['A Varina'])




#restaurants = {'restaurant_name': {'type': 'Italian', 'description': 'Italian food', 'link': 'link_placeholder', 'location': 'adress_placeholder'}, 
#               'restaurant_name2': {'type': 'Italian', 'description': 'Italian food', 'link': 'link_placeholder', 'location': 'adress_placeholder'}}