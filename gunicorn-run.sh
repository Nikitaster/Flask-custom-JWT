#!/bin/bash
source venv/bin/activate
gunicorn --certfile cert.pem --keyfile key.pem -b 0.0.0.0:8001 app:app