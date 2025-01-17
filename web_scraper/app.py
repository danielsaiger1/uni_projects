from flask import Flask, render_template, jsonify
import json

app = Flask(__name__)

# JSON-Daten laden
with open('./api/data/20250117_data_transformed.json', 'r', encoding='utf-8') as f:
    json_data = json.load(f)

@app.route('/')
def index():
    return render_template('index.html', data=json_data)

@app.route('/api/data')
def api_data():
    # JSON-Daten als API-Endpunkt zurückgeben
    return jsonify(json_data)

if __name__ == '__main__':
    app.run(debug=True)
