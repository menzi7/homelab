#!/bin/bash

# Directory variables
SOURCE_DIR="/etc/letsencrypt/archive/pi.menzi.dk"
DOCKGE_DIR="/opt/dockge/cert"
UNIFI_DIR="/opt/containers/unifiController/cert"
ZABBIX_DIR="/opt/containers/zabbix/zbx_env/etc/ssl/nginx"
HA_DIR="/opt/containers/homeAssistant/cert"
VAULTWARDEN_DIR="/opt/containers/vaultwarden/cert"
ACTUAL_DIR="/opt/containers/actual/data"

# copy newest cert to container folder

# Dockge
cp -f $(ls -t ${SOURCE_DIR}/fullchain*.pem | head -n 1) ${DOCKGE_DIR}/fullchain.pem
cp -f $(ls -t ${SOURCE_DIR}/privkey*.pem | head -n 1) ${DOCKGE_DIR}/privkey.pem
docker restart dockge

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

# Vaultwarden
cp -f $(ls -t ${SOURCE_DIR}/fullchain*.pem | head -n 1) ${VAULTWARDEN_DIR}/fullchain.pem
cp -f $(ls -t ${SOURCE_DIR}/privkey*.pem | head -n 1) ${VAULTWARDEN_DIR}/privkey.pem
docker restart vaultwarden

# Actual
cp -f $(ls -t ${SOURCE_DIR}/fullchain*.pem | head -n 1) ${ACTUAL_DIR}/ssl.crt
cp -f $(ls -t ${SOURCE_DIR}/privkey*.pem | head -n 1) ${ACTUAL_DIR}/ssl.key
docker restart actual