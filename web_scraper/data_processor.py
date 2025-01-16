from datetime import datetime
import pandas as pd
import json

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
        dataframe = pd.json_normalize(data_input)
        return dataframe
        
def main():
    processor = Processor('./output')
    data_raw = processor.load_data()
    df = processor.json_to_df(data_raw)
    
    print(df.head())

if __name__ == "__main__":
    main()
