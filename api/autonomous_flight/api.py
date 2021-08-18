from flask import Flask, jsonify, request
import json

import subprocess

app = Flask(__name__)
@app.route('/')
def hello():
    json_file = {}
    json_file['query'] = 'hello'
    return jsonify(json_file)

@app.route('/autoflight', methods = ['POST'])
def autonomouFlightDelivery():
    # Activate venv and run script


    json_file = {}

    requestData = request.data
    requestData = json.loads(requestData.decode('utf8'))

    # print(requestData['lat'])
    return jsonify({'query': 'success'})

if __name__ == '__main__':
    app.run()