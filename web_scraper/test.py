import re
import pandas as pd

class AddressSplitter:
    def split_address(self, address):
        # Regex für Straße, Hausnummer (mit Zusatz), PLZ und Stadt
        pattern = r"^(.*?)(\d{1,3}[a-zA-Z]?)\s+(\d{5})\s+(.*)$"
        match = re.match(pattern, address)
        if match:
            street = match.group(1).strip()
            house_number = match.group(2)
            postal_code = match.group(3)
            city = match.group(4).strip()
            return pd.Series([street, house_number, postal_code, city])
        else:
            return pd.Series([None, None, None, None])

# Beispiel
address_splitter = AddressSplitter()
address = "Fischmarkt 4c 22767 Hamburg"
result = address_splitter.split_address(address)
print(result)