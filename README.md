## Flask custom JSON WEb Token (JWT)

### Installation
```bash
git clone https://gitlab.com/nikitaster/flask-custom-jwt.git
cd flask-custom-jwt
python3 -v venv venv
source venv/bin/activate
pip3 install --upgrade-pip
pip3 install -r requirements.txt
```

### Generate ssl keys
```bash
openssl req -x509 -newkey rsa:4096 -nodes -out cert.pem -keyout key.pem -days 365
```


### Run 
(on port 8001) 
```bash
./gunicorn-run.sh
```
or manually
```bash
source venv/bin/activate
gunicorn --certfile cert.pem --keyfile key.pem -b 0.0.0.0:8001 app:app
```
### Nginx Configuration for proxy to gunicorn
```nginx
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
}
```

### Systemd UNIT
##### Create unit file
/etc/systemd/system/flask-custom-jwt.service  
```bash
[Unit]
Description=gunicorn flask-custom-jwt daemon
After=network.target

[Service]
User=root
WorkingDirectory=/home/ubuntu/flask-custom-jwt
Restart=always
ExecStart=/bin/bash gunicorn-run.sh

[Install]
WantedBy=multi-user.target
```

##### Run and enable
```bash
systemctl start flask-custom-jwt.service  
systemctl enable flask-custom-jwt.service 
```
