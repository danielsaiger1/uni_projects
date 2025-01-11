from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.common.exceptions import TimeoutException
from bs4 import BeautifulSoup
from typing import Dict
import time

#selenium nutzen um gesamte liste zu laden
#Küchenstile etc. auslesen, um erkennung zu ermöglichen

# URL of webpage
URL = "https://www.hamburg-tourism.de/shoppen-geniessen/restaurants-cafes/restaurants-von-a-bis-z/"

# WebDriver options
options = webdriver.ChromeOptions()
options.add_argument("--log-level=3")  # reduces logs to WARN and ERROR 
driver = webdriver.Chrome(options=options)

def load_page(URL):
    try:
        # load webpage
        driver.get(URL)
        driver.implicitly_wait(10) 

        try:
            # wait until consent banner is shown
            WebDriverWait(driver, 10).until(
                EC.presence_of_element_located((By.CSS_SELECTOR, "#usercentrics-root"))
            )

            # deny consent banner
            shadow_host = driver.find_element(By.CSS_SELECTOR, "#usercentrics-root")
            shadow_root = shadow_host.shadow_root
            deny_button = shadow_root.find_element(By.CSS_SELECTOR, "button[data-testid='uc-deny-all-button']")
            deny_button.click()

        except:
            print("No consent banner found.")
        
        initial_divs = driver.find_elements(By.CSS_SELECTOR, 'div[data-list-id]')
        
        # expand listings
        expand_teaser = WebDriverWait(driver, 10).until(
            EC.element_to_be_clickable((By.XPATH, "//a[contains(text(), 'Ganze Liste anzeigen')]"))
        )
        driver.execute_script("arguments[0].click();", expand_teaser)
        
        #sobald sich die Anzahl der Divs ändert wird der HTML Code in page_raw geladen und der driver beendet
        WebDriverWait(driver, 10).until(
            lambda driver: len(driver.find_elements(By.CSS_SELECTOR, 'div[data-list-id]')) > len(initial_divs)
        )
        
        page_raw = driver.page_source
        return page_raw

    except TimeoutException:
        print("A timeout has occurred.")
        return None

    finally:
        driver.quit()

html = load_page(URL)

if html:
    print("HTML loaded successfully")
else:
    print("HTML while loading site")


def load_data(webpage):

    try:
        soup = BeautifulSoup(webpage, "html.parser")

        teaser_list = soup.find("div", class_="teaserList-inline__page")

        listings = teaser_list.find_all("article", class_="listTeaser")

        restaurants: Dict[str, Dict[str, Dict[str, str]]] = {}

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
        
        print('Data loaded successfully')
        return restaurants
    
    except:
        print('Error while loading data.')

data = load_data(html)

print(data)





#restaurants = {'restaurant_name': {'type': 'Italian', 'description': 'Italian food', 'link': 'link_placeholder', 'location': 'adress_placeholder'}, 
#               'restaurant_name2': {'type': 'Italian', 'description': 'Italian food', 'link': 'link_placeholder', 'location': 'adress_placeholder'}}