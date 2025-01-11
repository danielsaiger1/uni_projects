from web_scraper.scraper import Scraper
from selenium import webdriver
import json

class Dataprocessor:
    def get_data(self, URL):
        
        options = webdriver.ChromeOptions()
        options.add_argument("--log-level=3")  # reduces logs to WARN and ERROR 
        
        driver = webdriver.Chrome(options=options)

        scraper = Scraper(URL, options, driver)
        
        html = scraper.load_page_raw()

        self.data = scraper.load_data(html)

        return self.data
    

def main():
    URL = "https://www.hamburg-tourism.de/shoppen-geniessen/restaurants-cafes/restaurants-von-a-bis-z/"
    
    processor = Dataprocessor()
    
    restaurant_data = processor.get_data(URL)
    
main()