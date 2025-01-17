from flask import Flask, render_template
import json

app = Flask(__name__)

with open('./api/data/20250118_data_transformed.json', 'r') as file:
    data = json.load(file)


@app.route('/')
def index():
    return render_template('index.html')

@app.route('/restaurants')
def restaurants():
    # Hier geben wir die Daten an das HTML Template weiter
    return render_template('restaurants.html', restaurants=data)

if __name__ == '__main__':
    app.run(debug=True)
