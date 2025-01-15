from datetime import datetime
import json
class Processor:
    def __init__(self, input_path):
        self.input_path = input_path
    
    def load_data(self):
        today = datetime.today().strftime('%Y%m%d')
        with open(f"{self.input_path}/{today}_output_data.json", 'r') as f:
            self.data = json.load(f)
            return self.data

processor = Processor('./output')

data = processor.load_data()

print(data)