# Homelab Evolution

A Proxmox-based homelab designed for reliably self-hosting services along with experimenting with new technologies via disposable VM environments. The setup is heavily focused on Infrastructure-as-Code and automation.

## Quick Links

> Documenting is in-progress.


## Status

| Area | State |
|------|-------|
| Migration from bare-metal server | Done |
| Rework of backup strategy and targets | In progress | 
| Observability | Makeshift Dozzle, Uptime Kuma (on NAS) and Glance |
| Kubernetes | Soon. K3s with Cilium and NFS CSI planned. |

## Hardware

#### Compute
| Logo | Device | Specs | Role |
|-|-|-|-|
| ![HP](https://cdn.simpleicons.org/hp?size=32) | HP EliteDesk 800 G2 SFF [1] |i5-6500 8GB RAM| NAS |
| ![Lenovo](https://cdn.simpleicons.org/lenovo?size=32) | Lenovo Thinkcentre M700 |i3-6100T 16GB RAM| Main Proxmox Node |
| ![HP](https://cdn.simpleicons.org/hp?size=32) | HP EliteDesk 800 G2 SFF [2] |i5-6500 8GB RAM |  Testing Proxmox Node |
| ![Lenovo](https://cdn.simpleicons.org/lenovo?size=32) | Lenovo Thinkpad T14 | i7-10610U 32GB RAM | Future Proxmox Node |

#### Networking

| Logo | Device | Role |
|-|-|-|
| ![tplink](https://cdn.simpleicons.org/tplink?size=32) | TP-Link Archer C6 | Wi-Fi |
| ![tplink](https://cdn.simpleicons.org/tplink?size=32) | TP-Link TL-SG108E | Managed Switch |
| ![tplink](https://cdn.simpleicons.org/tplink?size=32) | TP-Link TL-SG1006PP | PoE Switch powering the Cameras |


## Infrastructure
| Logo | Name | Description |
|:-:|-----|-------------|
| ![Debian](https://cdn.simpleicons.org/debian?size=32) | Debian | Main Linux distribution used |
| ![Fedora](https://cdn.simpleicons.org/fedora?size=32) | Fedora Server | Alternative Linux distribution used |
| ![TrueNAS](https://cdn.simpleicons.org/truenas?size=32) | TrueNAS | NAS OS |
| ![Ansible](https://cdn.simpleicons.org/ansible/f00?size=32) | Ansible | Automation tool for configuration |
| <img src="https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/cloudflare-zero-trust.png" width="32" height="32" />  | Cloudflare | Zero-Trust Tunnel for exposing services securely on the internet |
| ![Tailscale](https://cdn.simpleicons.org/tailscale?size=32) | Tailscale | Private mesh network for services not exposed publicly |
| <img src="https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/webp/dozzle.webp" width="32" height="32" /> | Dozzle | Web-based log viewer for Docker | 


## Services
| Logo | Name | Description |
|:-:|-----|-------------|
| ![Glance](https://cdn.simpleicons.org/glance?size=32) | Glance | Dashboard | 
| <img src="https://kaneo.app/logo-512.png" width="32" height="32" /> | Kaneo | Project management tool | 
| <img src="https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/webp/docmost.webp" width="32" height="32" /> | Docmost | Wiki and documentation platform | 
| ![Karakeep](https://cdn.simpleicons.org/karakeep?size=32) | Karakeep | Bookmark manager | 
| ![Jellyfin](https://cdn.simpleicons.org/jellyfin?size=32) | Jellyfin | Media streaming service | 
| ![Immich](https://cdn.simpleicons.org/immich?size=32) | Immich | Photo and Video management (testing) | 
| <img src="https://repository-images.githubusercontent.com/459944886/a6e61d23-9090-4cc4-946d-c5d9c189240f" width="32" height="32" /> | SilverBullet | Programmable browser-based Markdown editor |
| <img src="https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/frigate.svg" width="32" height="32" /> | Frigate | NVR with realtime object detection |
| <img src="https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/home-assistant.svg" width="32" height="32" /> | Home Assistant | Home automation hub, integrates with Frigate over MQTT |
| <img src="https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/mqtt.svg" width="32" height="32" /> | Mosquitto | MQTT broker for Frigate/Home Assistant events |