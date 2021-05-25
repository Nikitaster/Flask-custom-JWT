## Flask custom JSON WEb Token (JWT)

### Installation
    clone this project

    cd flask-custom-jwt
    python3 -v venv venv
    source venv/bin/activate
    pip3 install --upgrade-pip
    pip3 install -r requirements.txt

### Generate ssl keys
```bash
openssl req -x509 -newkey rsa:4096 -nodes -out cert.pem -keyout key.pem -days 365
```


### Run 
(on port 8001)
    ./gunicorn-run.sh

### Nginx Configuration for proxy to gunicorn
```Nginx

server {
    listen 443 ssl;

    server_name localhost;

    ssl_certificate /home/ubuntu/flask-custom-jwt/cert.pem;
    ssl_certificate_key /home/ubuntu/flask-custom-jwt/key.pem;

    location /jwt/auth {
        include proxy_params;
        proxy_pass https://0.0.0.0:8001/auth;
    }

    location /jwt/protected {
        include proxy_params;
        proxy_pass https://0.0.0.0:8001/protected;
    }

    location /jwt/unprotected {
        include proxy_params;
        proxy_pass https://0.0.0.0:8001/unprotected;
    }
```



}
