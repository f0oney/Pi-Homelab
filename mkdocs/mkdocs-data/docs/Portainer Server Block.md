This is a similar structure to Proxmox:

```bash
server {
    listen 80; # http port
    listen [::]:80; # used for ipv6

    server_name portainer.user.local www.portainer.user.local;
    return 301 https://portainer.user.local;
}

server {
    listen 443 ssl;
    listen [::]:443 ssl;
    server_name portainer.user.local www.portainer.user.local;

    ssl_certificate /etc/openssl/certificates/user.crt;
    ssl_certificate_key /etc/openssl/keys/user.key;

   location / {

       proxy_pass https://localserver:${PORT};
       proxy_http_version 1.1;
       proxy_set_header Upgrade $http_upgrade;
       proxy_set_header Connection "upgrade";

       proxy_set_header Host $host;
       proxy_set_header X-Real-IP $remote_addr;
       proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
       proxy_set_header X-Forwarded-Proto $scheme;

       proxy_buffering off;
       client_max_body_size 0;
   }
}
```
