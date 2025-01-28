## I got HTTPS working for HomeAssistant
 
To summarize a long chat with chatgpt; 


```yml
# In docker-compose.yml I mapped volume where the certbot certificates are:
volumes:
  - ./cert:/ssl:ro
```
This maps *./cert* on the host to */ssl* inside the containter <br>
More info about the *./cert* folder [here](/lab/certbot/README.md)

<br>

```yml
# I added the following in HomeAssistant/configuration.yaml
  ssl_certificate: /ssl/fullchain.pem
  ssl_key: /ssl/privkey.pem

# Along with these for security
  ip_ban_enabled: true
  login_attempts_threshold: 3
```
