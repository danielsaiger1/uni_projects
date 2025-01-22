from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.common.exceptions import TimeoutException
from bs4 import BeautifulSoup
import requests
from typing import Dict

class Scraper:
    def __init__(self, URL, options, driver):
        self.URL = URL
        self.options = options
        self.driver = driver
        
    def load_page_raw(self):
        try:
            # load webpage
            self.driver.get(self.URL)
            self.driver.implicitly_wait(10) 
            
            # click consent banner
            self._handle_consent_banner()

            self.initial_divs = self.driver.find_elements(By.CSS_SELECTOR, 'div[data-list-id]')

            # expand listings
            self._expand_listings()
        
            self.page_raw = self.driver.page_source
            return self.page_raw

        except TimeoutException:
            print("A timeout has occurred.")
            return None

        finally:
            self._close_driver()
            
            
    def _handle_consent_banner(self):
        try:
            # wait until consent banner is shown
            WebDriverWait(self.driver, 10).until(
                EC.presence_of_element_located((By.CSS_SELECTOR, "#usercentrics-root"))
            )
            # deny consent banner
            shadow_host = self.driver.find_element(By.CSS_SELECTOR, "#usercentrics-root")
            shadow_root = shadow_host.shadow_root
            deny_button = shadow_root.find_element(By.CSS_SELECTOR, "button[data-testid='uc-deny-all-button']")
            deny_button.click()
        except:
            print("No consent banner found.")       
    
    def _expand_listings(self):
            # expand listings
            expand_teaser = WebDriverWait(self.driver, 10).until(
                EC.element_to_be_clickable((By.XPATH, "//a[contains(text(), 'Ganze Liste anzeigen')]"))
            )
            self.driver.execute_script("arguments[0].click();", expand_teaser)
            
            #sobald sich die Anzahl der Divs ändert wird der HTML Code in page_raw geladen und der driver beendet
            WebDriverWait(self.driver, 10).until(
                lambda driver: len(driver.find_elements(By.CSS_SELECTOR, 'div[data-list-id]')) > len(self.initial_divs)
            )
            
    def _close_driver(self):
        if self.driver:
            self.driver.quit()
            
    def load_data(self, webpage):
        try:
            soup = BeautifulSoup(webpage, "html.parser")

            teaser_list = soup.find("div", class_="teaserList-inline__page")
            if not teaser_list:
                raise ValueError("Keine Teaser-Liste gefunden")

            listings = teaser_list.find_all("article", class_="listTeaser")
            
            cuisine_types = self._fetch_cuisine_types(webpage)
            
            restaurants: Dict[str, Dict[str, str]] = {}

            for idx, article in enumerate(listings):
                name = article.find('h3').text.strip()
                
                description = article.find('p').text.strip()
                
                link = f"https://www.hamburg-tourism.de{article.find('a')['href']}"
                
                location, sub_link = "N/A", "N/A"
                if link:
                        subpage = requests.get(link)
                        if subpage.status_code == 200:
                            location, sub_link = self._get_subinfo(subpage)

                features = []
                ul = article.find('ul')  
                if ul:
                    list_items = ul.find_all('li')
                    for li in list_items:
                        features.append(li.text.strip())
                
                cuisine_type = [i for i in features if i in cuisine_types]
                
                type = 'N/A'
                for i in features:
                    if i in ['Restaurant', 'Café/Bistro']:
                        type = i
                        break
                
                features = [feature for feature in features if feature not in ['Restaurant', 'Café/Bistro', '€€€']]
                features = [feature if feature else "N/A" for feature in features]
                
                restaurants[idx] = {
                    'name' : name,
                    'description' : description,
                    'type' : type,
                    'cuisine_type' : cuisine_type,
                    'location' : location,
                    'features' : features,
                    'link' : link,
                    'sublink': sub_link
                }
          
            
            print('Data loaded successfully')
            return restaurants
        
        except Exception as e:
            print(f"Error while loading data: {str(e)}")
        
    
    def _fetch_cuisine_types(self, webpage):
        soup = BeautifulSoup(webpage, "html.parser")
        cuisine_inputs = soup.find_all('input', {'type': 'checkbox', 'name': 'filter[cuisinetype][]'})
    
        self.cuisine_types = [
            soup.find('label', {'for': elem.get('id')}).text.strip()
            for elem in cuisine_inputs if elem.get('id')
        ]
        return self.cuisine_types
    
    def _get_subinfo(self, subpage):
        soup = BeautifulSoup(subpage.text, "html.parser")
        contact_block = soup.find('div', class_='contact__address')
        divs = contact_block.find_all('div', class_='contact__address__informationBundle')
        
        if len(divs) > 0:
            first_bundle = divs[0]
            text_content = first_bundle.get_text(strip=True)
            if text_content:
                self.adress = text_content
                
        # Zweites Bundle (für den Link)
        if len(divs) > 1:
            second_bundle = divs[1]
            link = second_bundle.find('a')
            if link and 'href' in link.attrs:
                self.link = link['href']
                            
        return self.adress, self.link
        
        
            