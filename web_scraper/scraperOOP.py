from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.common.exceptions import TimeoutException
from bs4 import BeautifulSoup
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
                    
                restaurants[name] = {
                    'description' : description,
                    'features' : features,
                    'link' : link
                }
            
            print('Data loaded successfully')
            return restaurants
        
        except Exception as e:
            print(f"Error while loading data: {str(e)}")