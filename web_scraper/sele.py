from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.action_chains import ActionChains

# Setup the webdriver (assuming you're using Chrome)
driver = webdriver.Chrome()

# Open the target website
driver.get("https://www.hamburg-tourism.de/shoppen-geniessen/restaurants-cafes/restaurants-von-a-bis-z/")

# Wait for the shadow DOM to load, add an explicit wait if needed
driver.implicitly_wait(10)  # seconds

# Find the host element for the shadow DOM
shadow_host = driver.find_element(By.CSS_SELECTOR, "#usercentrics-root")  # Update with the actual selector <div id="usercentrics-root" data-created-at="1736502742073" style=""></div>

# Access the shadow root
shadow_root = shadow_host.shadow_root


# Perform other interactions as necessary (e.g., clicking 'Only necessary cookies')
deny_button = shadow_root.find_element(By.CSS_SELECTOR, "button[data-testid='uc-deny-all-button']")
deny_button.click()

