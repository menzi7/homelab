## I got HTTPS working for HomeAssistant
 
To summarize a long chat with chatgpt; 


```yml
# In docker-compose.yml I mapped volume where the certbot certificates are:
/etc/letsencrypt/archive/pi.menzi.dk:/ssl:ro
```
This maps */etc/letsencrypt/archive/pi.menzi.dk* on the host to */ssl* inside the containter

<br>

```yml
# I added the following in HomeAssistant/configuration.yaml
  ssl_certificate: /ssl/fullchain1.pem
  ssl_key: /ssl/privkey1.pem

# Along with these for security
  ip_ban_enabled: true
  login_attempts_threshold: 3
```

<br>

```sh
# Nginx is just used for allowing ACME-challenge and to deny everything else:
/etc/nginx/sites-available/pi.menzi
server {
    listen 80;
    server_name pi.menzi.dk;

    location /.well-known/acme-challenge/ {
        allow all;
    }

    location / {
        return 403;
    }
}
```
To secure port 80, further, I applied [this](https://community.fortinet.com/t5/FortiGate/Technical-Tip-How-to-allow-Let-s-Encrypt-traffic-through-the/ta-p/334464) on the firewall. Only allowing ACME challenges, and blocking all other HTTP requests

<br>
Certbot can successfully renew my certificate, I can access Homeassistant remotely and locally with said SSL certificate. Anyone trying to connect with port 80 will be blocked by my firewall, and if, against all odds, they get through the firewall, the nginx will return 403 forbidden.