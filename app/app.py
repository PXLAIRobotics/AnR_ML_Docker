#!/usr/bin/env python3

from flask import Flask

app = Flask(__name__)

@app.route("/")
def hello():
    return "Hello World!!!"

if __name__ == '__main__':
    host = "0.0.0.0"
    port = 5000
    debug = False

    app.run(host, port, debug)
