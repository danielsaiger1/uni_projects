from datetime import datetime
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
            print(f"Data not found. Check {e}")
            return None
        
def main():
    processor = Processor('./output')
    data = processor.load_data()

if __name__ == "__main__":
    main()
