#!/usr/bin/env python3

from flask import Flask, jsonify, request
from flask_cors import CORS, cross_origin
import pickle
from prophet import Prophet

app = Flask(__name__)
CORS(app)

with open('forecast_model.pckl', 'rb') as fin:
    model = pickle.load(fin)

@app.route('/')
def hello_world():
    return 'Hello World!'

@app.route('/api/v1.0/forecast/energy', methods=['POST'])
def predict():
    days = int(request.json['days'])
    future = model.make_future_dataframe(periods=days)
    forecast = model.predict(future)
    data = forecast[['ds', 'yhat', 'yhat_lower', 'yhat_upper']][-days:]

    result = data.to_json(orient='records', date_format='iso')

    return result

if __name__ == '__main__':
    app.run(host='0.0.0.0')

