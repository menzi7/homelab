## HTTPS
Enabiling https for the Unifi controller is pretty straight forward

It just requires a couple enviounment vars and the certificate files placed in *./cert*
### Compose file
```yml
environment:
  - CERT_IS_CHAIN=true
  - CERTNAME=fullchain.pem
  - CERT_PRIVATE_NAME=privkey.pem
volumes:
  - ./data:/unifi/data
```

More info about the *./cert* folder [here](/lab/certbot/README.md)