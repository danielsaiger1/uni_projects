from selenium import webdriver
from selenium.webdriver.common.by import By
import time

chrome_options = webdriver.ChromeOptions()
chrome_options.add_experimental_option("detach", True)

driver = webdriver.Chrome(options = chrome_options)
driver.get("https://www.selenium.dev/selenium/web/web-form.html")

# Handle the email input field
email_input = driver.find_element(By.ID, "my-text-id")
email_input.clear()  # Clear field

email = "admin@localhost.dev"
email_input.send_keys(email)  # Enter text

check_input = driver.find_element(By.ID, "my-radio-2")
check_input.click()

time.sleep(5)

submit = driver.find_element(By.CSS_SELECTOR, ".btn.btn-outline-primary.mt-3")
submit.click()