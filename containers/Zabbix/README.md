![Zabbix](https://i.postimg.cc/Y991FmPH/11-June-15-09-21-firefox.png)

# Updating a containerized Zabbix

### Step 1: Backup
`docker exec -it zabbix-mysql sh -c 'mariadb-dump -u zabbix -p zabbix' > zabbix_backup.sql`

It might be easier to enter the container, creating the backup and then copying it out, but the end result is the same.

> **_NOTE:_**  If MariaDB is older than 10.5, use `mysqldump` instead of `mariadb-dump`

### Step 2: Update docker-compose.yml
Change the images to the new version and save the file.
e.g. `image: zabbix/zabbix-server-mysql:alpine-7.0-latest`
becomes: `image: zabbix/zabbix-server-mysql:alpine-7.2-latest`

### Step 3: Upgrade MariaDB
1. First, down all the zabbix containers 
`docker compose down`
2. Then only start the SQL server 
`docker compose up -d zabbix-mysql`
3. Enter the container 
`docker exec -it zabbix-mysql sh`
4. Start the upgrade by running:
`mariadb-upgrade -p`
It will prompt for the root password. If the env_var isn't changed, its 'root_pwd'

> **_NOTE:_**  If MariaDB is older than 10.5, use `mysql_upgrade` instead of `mariadb-upgrade`

### Step 3: Start the Zabbix server
1. Start the Zabbix server
`docker compose up -d zabbix-server`
2. Verify thats it's upgrading the database by checking logs
`docker logs zabbix-server`
It should print
```
completed 1% of database upgrade
completed 1% of database upgrade
completed 1% of database upgrade
and so on...
```  

### Step 4: Start the web service and agent or troubleshoot
If the database upgrade was a success, start the other services
`docker compose up -d zabbix-agent`
`docker compose up -d zabbix-web`

If not, troubleshoot the error(s) found in either the zabbix server logs or sql logs.  

<br><br><br>

# The "S" in HTTPS stands for "sucks"
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