```bash
server {
    listen 80;
    listen [::]:80;

    server_name example.com www.example.com;
    return 301 https://example.com;
}

server {
    listen 443 ssl;
    listen [::]:443 ssl;
    server_name example.com www.example.com;

    ssl_certificate /etc/openssl/certificates/user.crt;
    ssl_certificate_key /etc/openssl/keys/user.key;

   location / {
       proxy_pass http://mkdocs:8000;
       proxy_set_header Host $host;
       proxy_set_header X-Real-IP $remote_addr;
       proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
       proxy_set_header X-Forwarded-Proto $scheme;
   }
}
```

`proxy_pass` - As we are using a docker network, which this service is connected to, we can simply call it's docker container name, followed by it's default port 8000.