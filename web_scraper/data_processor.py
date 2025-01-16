from datetime import datetime
import pandas as pd
import json
import re

class Processor:
    def __init__(self, input_path):
        self.input_path = input_path
    
    def load_data(self):
        today = datetime.today().strftime('%Y%m%d')
        try:
            with open(f"{self.input_path}/{today}_output_data.json", 'r') as f:
                self.data = json.load(f)
                print("Data loaded successfully")
                return self.data
        except Exception as e:
            print(f"Data not found. Error: {e}")
            return None
    
    def json_to_df(self, data_input):
        records = []
        for item in data_input.items():
            records.append(item[1])
        self.dataframe = pd.DataFrame(records)
        return self.dataframe
    
    def split_address(self, address):
        # Regex für Adresse, die Hausnummer und PLZ zusammen enthält
        pattern = r"^(.*?)(\d{1,3})(\d{5})\s+(.*)$"
        match = re.match(pattern, address)
        if match:
            street = match.group(1).strip()
            house_number = match.group(2)
            postal_code = match.group(3)
            city = match.group(4).strip()
            return pd.Series([street, house_number, postal_code, city])
        else:
            return pd.Series([None, None, None, None])

    def transform_addresses(self, df):
        # Wendet split_address auf jede Zeile der 'location'-Spalte an und gibt die neuen Spalten zurück
        df[['street', 'house_number', 'postal_code', 'city']] = df['location'].apply(
            lambda loc: self.split_address(loc)
        )
        df = df.drop(columns=['location'])
        return df

def main():
    processor = Processor('./output')
    data_raw = processor.load_data()
    df = processor.json_to_df(data_raw)
    
    df = processor.transform_addresses(df)
    
    print(df.head())

if __name__ == "__main__":
    main()
