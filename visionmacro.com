server {
    #listen 80;
    #listen [::]:80;
    server_name visionmacro.com;
    root   /var/www/html/production/visionmacro.com;
    index  index.html;        



    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/aprendeaconstruir.com/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/aprendeaconstruir.com/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot


}


server {
    if ($host = visionmacro.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    server_name visionmacro.com;
    listen 80;
    return 404; # managed by Certbot


}