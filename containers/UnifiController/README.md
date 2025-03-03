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


## Discovery
Inform host needs to be overridden, because the controller sends out the container IP, which isn't reachable from other devices.  
```settings > advanced > inform host > override > type the hostname or IP of the docker host.```

#### Can't discover across vlans.
* ssh into AP using the default credentials
* type ```set-inform http://x.x.x.x:8080/inform``` either IP or hostname of the controller
* click adopt in the controller
