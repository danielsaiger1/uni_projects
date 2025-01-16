import re

# Originaler String
address = "Ditmar-Koel-Straße 28 20459 Hamburg"

# Schritt 1: \n und überflüssige Leerzeichen entfernen
cleaned_address = address.strip()

# Schritt 2: Mit einem regulären Ausdruck Hausnummer und PLZ trennen
pattern = r"^(.*?)(\d+)\s+(\d{5})\s+(.*)$"
match = re.match(pattern, cleaned_address)

if match:
    street = match.group(1).strip()
    house_number = match.group(2)
    postal_code = match.group(3)
    city = match.group(4).strip()

    print(f"Straße: {street}")
    print(f"Hausnummer: {house_number}")
    print(f"PLZ: {postal_code}")
    print(f"Stadt: {city}")
else:
    print("Adresse konnte nicht verarbeitet werden.")