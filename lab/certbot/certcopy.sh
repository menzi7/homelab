#!/bin/bash

# Directory variables
SOURCE_DIR="/etc/letsencrypt/archive/pi.menzi.dk"
UNIFI_DIR="/home/tme/containers/UnifiController/cert"
ZABBIX_DIR="/home/tme/containers/Zabbix/zbx_env/etc/ssl/nginx"
HA_DIR="/home/tme/containers/HomeAssistant/cert"

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