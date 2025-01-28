## The "S" in HTTPS stands for "sucks"
But only if you're an idiot like me.

First of all, thanks to [u/curious-jorge-IT](https://www.reddit.com/r/zabbix/comments/17aujk3/configuring_https_on_zabbix_deployment_via_docker/) on reddit, if it wasn't for him, I would probably have given up, and still be pressing "Advanced" and "Proceed". 

### Opstacle 1: Location
The Zabbix docker has a folder called `certs`. Great, that must be where they go. Wrong, they go in `./zbx_env/etc/ssl/nginx/`, ofcourse.

### Opstacle 2: Naming
Zabbix wants `ssl.key` and `ssl.crt` files, but Let's Encrypt generates `privkey.pem` and `fullchain.pem` files. <br>
Luckily for me they can be renamed. I'm doing this with the [certcopy.sh](/lab/certbot/README.md) script i made, this also copies the cert to the correct location.

### Opstacle 3: Permission
Restart the container. Unhealthy. Nothing in the browser. docker logs zabbix-web. `[emerg] cannot load certificate key /etc/ssl/nginx/ssl.key: BIO_new_file() failed (SSL: error:8000000D:system library::Permission denied`. Fantastic. Remembering something about permissions on reddit.

`sudo chmod 640 ssl.key` wasn't enough for me, so I went all in and did 777.

### Opstacle 4: NGINX
I was prepaired for this one, not happy about it, but knew about it. Containers arent persistent, so I copied the nginx_ssl.conf file out, edited the `server_name` to match that of the certificate, then mapped the modified .conf file to the original destination in the compose file.

```yml
volumes:
  - ./zbx_env/etc/nginx/nginx_ssl.conf:/etc/nginx/http.d/nginx_ssl.conf
```

## profit?