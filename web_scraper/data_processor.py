from scraperOOP import Scraper
from selenium import webdriver

URL = "https://www.hamburg-tourism.de/shoppen-geniessen/restaurants-cafes/restaurants-von-a-bis-z/"
options = webdriver.ChromeOptions()
options.add_argument("--log-level=3")  # reduces logs to WARN and ERROR 
driver = webdriver.Chrome(options=options)

scraper = Scraper(URL, options, driver)
html = scraper.load_page_raw()

data = scraper.load_data(html)

print(data)