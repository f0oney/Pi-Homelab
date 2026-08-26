Proxmox had to be setup slightly differently for this code block. 

As Proxmox relies on SSL, HTTPS connection, we needed to make sure that 'https' is used in the 'proxy_pass' line, and that additional proxy headers are used. See the full code block below:

```bash
server {
    listen 80; # http port
    listen [::]:80; # used for ipv6

    server_name proxmox.user.local www.proxmox.user.local;
	return 301 https://proxmox.user.local;
}

server {
    listen 443 ssl;
    listen [::]:443 ssl;
    server_name proxmox.user.local www.proxmox.user.local;

    ssl_certificate /etc/openssl/certificates/user.crt;
    ssl_certificate_key /etc/openssl/keys/user.key;

   location / {

       # Ensuring 'https' is used in the below line, instead of 'http'
       proxy_pass https://localserver:${PORT};
       proxy_http_version 1.1;
       proxy_set_header Upgrade $http_upgrade;
       proxy_set_header Connection "upgrade";

       # The additional headers used
       proxy_set_header Host $host;
       proxy_set_header X-Real-IP $remote_addr;
       proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
       proxy_set_header X-Forwarded-Proto $scheme;

       proxy_buffering off;
       client_max_body_size 0;
   }
}
```

The comments in the code blocks above show what has been amended, and what has been added.
