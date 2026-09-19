Example server block setup for Vaultwarden:

```bash
upstream vaultwarden-default {
  zone vaultwarden-default 64k;
  server vaultwarden:80;
  keepalive 2;
}

map $http_upgrade $connection_upgrade {
    default upgrade;
    ''      "";
}

server {
    listen 80; # http port
    listen [::]:80; # used for ipv6

    server_name example.com example.com;
    return 301 https://example.com;
}

server {
    listen 443 ssl;
    listen [::]:443 ssl;
    http2 on;
    server_name example.com www.example.com;

    ssl_certificate /etc/openssl/certificates/user.crt;
    ssl_certificate_key /etc/openssl/keys/user.key;

   location / {

       proxy_pass http://vaultwarden-default;

       client_max_body_size 525M;

       proxy_http_version 1.1;
       proxy_set_header Upgrade $http_upgrade;
       proxy_set_header Connection $connection_upgrade;

       proxy_set_header Host $host;
       proxy_set_header X-Real-IP $remote_addr;
       proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
       proxy_set_header X-Forwarded-Proto $scheme;
   }
}
```

`vaultwarden-default` - Upstream block that contains the proxy_pass address. As with all other docker containers, this will call the docker name, followed by it's default port. This will be `vaultwarden:80`.