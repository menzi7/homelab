  <h3 align="center">Homelab</h2>
  <p align="center">
    IaC and documentation of my homelab.
  </p>

## 📖 Overview

This repository declares all of my infrastructure. I also host all of my documentation here. This is the beginning of my homelab adventure, so it's still in the very early stages, mainly because of budget, but also because of space, as I live in an apartment.

Admittedly, usage of "all" describe the end goal of this repo, not the current state. But, I will get there some day.

---

## 🎨 Components

### Infrastructure management

- Same way I'm managing everything else: barely.

### Networking

- [Certbot](https://certbot.eff.org/): Automatic Let's Encrypt certificates.
- [Pi-hole](https://pi-hole.net/): DNS server with ad-blocking.

### Security

- [Fortinet](https://www.fortinet.com/): FortiGate, IPS, WAF, VPN.
- [Vaultwarden](https://github.com/dani-garcia/vaultwarden): Self-hosted password manager.

### Observability

- [Zabbix](https://www.zabbix.com/): Monitoring, visualization and alerts.
- [Fortinet](https://www.fortinet.com/): Network logs.

---

## 📂 Repository structure

Overview of this repo's structure:

```sh
📁 containers     # Docker applications
├──📁 HomeAssistant      # Configuration(s) for HomeAssistant
├──📁 PiHole             # Configuration(s) for PiHole
├──📁 UnifiController    # Configuration(s) for UnifiController
├──📁 Vaultwarden        # Configuration(s) for Vaultwarden
├──📁 Watchtower         # Configuration(s) for Watchtower
└──📁 Zabbix             # Configuration(s) for Zabbix
```

---

## ☁️ Dependencies

### Cloud Services

| Service                                     | Use                                                            | Cost              |
| --------------------------------------------| -------------------------------------------------------------- | ----------------- |
| [one.com](https://www.one.com/)             | Hosting my website, DNS, SMTP.                                 | DKK 708/yr        |
| [Fortinet](https://www.fortinet.com/)       | Not cloud, but still a dependency.                             | Free*             |
| [Let's Encrypt](https://letsencrypt.org/)   | Certificates.                                                  | Free              |
| [GitHub](https://github.com/)               | Hosting this repository and continuous integration/deployments | Free              |
|                                             |                                                                | Total: DKK 708/yr |

*Licence provided by my employer, but would otherwise be *expensive*, or have less features

### Internet

| Provider | Plan             | Speed (Down) | Speed (Up) | Latency | Cost       |
| -------- | ---------------- | ------------ | -----------| ------- | -----------|
| Norlys   | Fiber 300 Basic  | 300 Mbps     | 300 Mbps   | ~ 10ms  | Free*      |
|          |                  |              |            |         | Total: N/A |

*Cost covered by my employer, but would otherwise be about DKK 300/mo

### Electricity

| Item    | Consumption  | Rate      | Cost       |
| ------- | ------------ | --------- | ---------- |
| Homelab | tbd          | variable  | N/A        |
|         |              |           | Total: N/A |

---

## 🔧 Hardware

### Computing

| Count | Device                     | OS Disk Size  | Data Disk Size | Ram   | Operating System | Purpose        |
| ----- | -------------------------- | ------------- | -------------- | ----- | ---------------- | -------------- |
| 1     | Raspberry Pi 5b            | 128GB SD Card | N/A            | 8GB   | Debian 12        | Docker host    |

### Networking

| Count | Device                  | Eth Interfaces | SFP Interfaces | Platform       | Purpose              |
| ----- | ------------------------| -------------- | -------------- | -------------- | -------------------- |
| 1     | FortiGate 60F           | 10x 1G         | N/A            | FortiOS        | Firewall and Router  |
| 1     | Aruba 2530 24G PoE+     | 24x 1G         | 4x 1G          | ArubaOS-Switch | L2 PoE+ Switch       |
| 1     | Ubiquiti Unifi U6+      | 1x 1G          | N/A            | UniFi OS       | WiFi 6 Access Point  |

---

## 🤝 Thanks

Thanks to everyone in the homelab community, on the [homelab subreddit](https://www.reddit.com/r/homelab/) and on various forums that I've come to for help.

As you might already have seen, I've taken a ton of inspiration from [MacroPower](https://github.com/MacroPower/), so thanks MacroPower for making great [repos](https://github.com/MacroPower/homelab/).

And of course, all of our favourite: ChatGPT

---

## 🔏 License

This project is licensed under the MIT license, primarily because it's simple enough for me to understand, and so you can do whatever you want.

For more details, see [LICENSE](./LICENSE).

Ultimately though, I have a WTFPL mindset about any content produced by/for myself. If you like anything you see here, feel free to use it however you want. 

---
