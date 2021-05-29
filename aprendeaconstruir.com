server {
    #listen 80;
    #listen [::]:80;
    server_name aprendeaconstruir.com;
    root   /var/www/html/production/aprendeaconstruir.com;
    index  index.html index.php;
  
    location ~ \.php$ {
        include snippets/fastcgi-php.conf;        
        fastcgi_pass unix:/run/php/php8.0-fpm.sock;
    }   



    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/aprendeaconstruir.com/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/aprendeaconstruir.com/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot


}


server {
    if ($host = aprendeaconstruir.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    server_name aprendeaconstruir.com;
    listen 80;
    return 404; # managed by Certbot


}