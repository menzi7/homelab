#!/bin/bash

# Directory variables
SOURCE_DIR="/etc/letsencrypt/archive/pi.menzi.dk"
UNIFI_DIR="/home/tme/containers/UnifiController/cert"
ZABBIX_DIR="/home/tme/containers/Zabbix/zbx_env/etc/ssl/nginx"
HA_DIR="/home/tme/containers/HomeAssistant/cert"
PORTAINER_DIR="/home/tme/containers/Portainer/data/certs"
VAULTWARDEN_DIR="/home/tme/containers/Vaultwarden/cert"
UPTIME-KUMA_DIR="/home/tme/containers/Uptime-Kuma/cert"

# copy newest cert to container folder

# Unifi
cp -f $(ls -t ${SOURCE_DIR}/fullchain*.pem | head -n 1) ${UNIFI_DIR}/fullchain.pem
cp -f $(ls -t ${SOURCE_DIR}/privkey*.pem | head -n 1) ${UNIFI_DIR}/privkey.pem
docker restart unificontroller

# Zabbix
cp -f $(ls -t ${SOURCE_DIR}/fullchain*.pem | head -n 1) ${ZABBIX_DIR}/ssl.crt
cp -f $(ls -t ${SOURCE_DIR}/privkey*.pem | head -n 1) ${ZABBIX_DIR}/ssl.key
# Big no-no, but I would otherwise get permission error.
sudo chmod 777 ${ZABBIX_DIR}/ssl.key
docker restart zabbix-web

# HomeAssistant
cp -f $(ls -t ${SOURCE_DIR}/fullchain*.pem | head -n 1) ${HA_DIR}/fullchain.pem
cp -f $(ls -t ${SOURCE_DIR}/privkey*.pem | head -n 1) ${HA_DIR}/privkey.pem
docker restart homeassistant

# Portainer
cp -f $(ls -t ${SOURCE_DIR}/fullchain*.pem | head -n 1) ${PORTAINER_DIR}/cert.pem
cp -f $(ls -t ${SOURCE_DIR}/privkey*.pem | head -n 1) ${PORTAINER_DIR}/key.pem
docker restart portainer

# Vaultwarden
cp -f $(ls -t ${SOURCE_DIR}/fullchain*.pem | head -n 1) ${VAULTWARDEN_DIR}/fullchain.pem
cp -f $(ls -t ${SOURCE_DIR}/privkey*.pem | head -n 1) ${VAULTWARDEN_DIR}/privkey.pem
docker restart vaultwarden

# Uptime-Kuma
cp -f $(ls -t ${SOURCE_DIR}/fullchain*.pem | head -n 1) ${UPTIME-KUMA_DIR}/fullchain.pem
cp -f $(ls -t ${SOURCE_DIR}/privkey*.pem | head -n 1) ${UPTIME-KUMA_DIR}/privkey.pem
docker restart uptime-kuma