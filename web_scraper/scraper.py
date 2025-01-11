from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.common.exceptions import TimeoutException

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

        # wait until consent banner is shown
        WebDriverWait(driver, 10).until(
            EC.presence_of_element_located((By.CSS_SELECTOR, "#usercentrics-root"))
        )

        # deny consent banner
        shadow_host = driver.find_element(By.CSS_SELECTOR, "#usercentrics-root")
        shadow_root = shadow_host.shadow_root
        deny_button = shadow_root.find_element(By.CSS_SELECTOR, "button[data-testid='uc-deny-all-button']")
        deny_button.click()

        # expand listings
        expand_teaser = WebDriverWait(driver, 10).until(
            EC.element_to_be_clickable((By.XPATH, "//a[contains(text(), 'Ganze Liste anzeigen')]"))
        )
        expand_teaser.click()

        
        WebDriverWait(driver, 10).until(
            EC.presence_of_element_located((By.CSS_SELECTOR, "div.result-item"))
        )

        page = driver.page_source
        return page

    except TimeoutException:
        print("A timeout has occurred.")
        return None

    finally:
        driver.quit()


page = load_page(URL)

if page:
    print("Site loaded successfully")
else:
    print("Error while loading site")









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


print(restaurants['Zum Anker'])




#restaurants = {'restaurant_name': {'type': 'Italian', 'description': 'Italian food', 'link': 'link_placeholder', 'location': 'adress_placeholder'}, 
#               'restaurant_name2': {'type': 'Italian', 'description': 'Italian food', 'link': 'link_placeholder', 'location': 'adress_placeholder'}}