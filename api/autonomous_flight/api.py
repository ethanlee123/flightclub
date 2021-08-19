#********************************
# ACTIVATE VENV and run flask run
# modifications require you to ctrl+c and re run flask run
#********************************

from flask import Flask, jsonify, request
import json
from decouple import config
import paramiko
import sys
import time

usrnm = config("USER")
pw = config("PASSWORD")
rpi_ip = config("RPI_IP")

results = []

app = Flask(__name__)
@app.route('/')
def hello():
    json_file = {}
    json_file['query'] = 'hello'
    return jsonify(json_file)

@app.route('/autoflight', methods = ['POST'])
def autonomouFlightDelivery():
    ssh_conn()

    json_file = {}

    requestData = request.data
    requestData = json.loads(requestData.decode('utf8'))

    return jsonify({'query': 'success'})

if __name__ == '__main__':
    app.run()


def ssh_conn():
    try:
        client = paramiko.SSHClient()
        client.load_system_host_keys()
        client.connect(rpi_ip, username=usrnm, password=pw, timeout=3.0)

        ssh_stdin, ssh_stdout, ssh_stderr = client.exec_command("python Documents/rpi_test.py")
        print(ssh_stdout.read().decode("utf-8"))

        client.close()
    except:
        print("Failed to connect to rpi or could not exec commands")