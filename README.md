# Homelab Evolution

A Proxmox-based homelab designed for reliably self-hosting services along with experimenting with new technologies via disposable VM environments. The setup is heavily focused on Infrastructure-as-Code and automation.


## Evolution Status

| Area | State |
|------|-------|
| Docker Services | Fully operational |
| Rework of backup strategy and targets | In progress | 
| Kubernetes | K3s, Traefik, SOPS, Flux, Cloudflared |
| Kubernetes Migration | Only Frigate Left |

## Hardware

#### Compute
| Logo | Device | Specs | Role |
|-|-|-|-|
| ![HP](https://cdn.simpleicons.org/hp?size=32) | HP EliteDesk 800 G2 SFF [1] |i5-6500 8GB RAM| NAS |
| ![HP](https://cdn.simpleicons.org/hp?size=32) | HP EliteDesk 800 G2 SFF [2] |i5-6500 8GB RAM |  Proxmox/k3s Node |
| ![Lenovo](https://cdn.simpleicons.org/lenovo?size=32) | Lenovo Thinkcentre M710q |i3-7100T 8GB RAM| Proxmox/k3s Node |
| ![Lenovo](https://cdn.simpleicons.org/lenovo?size=32) | Lenovo Thinkcentre M700 |i3-6100T 16GB RAM| Proxmox/k3s Node |

#### Networking

| Logo | Device | Role |
|-|-|-|
| ![tplink](https://cdn.simpleicons.org/tplink?size=32) | TP-Link Archer C6 | Wi-Fi |
| ![tplink](https://cdn.simpleicons.org/tplink?size=32) | TP-Link TL-SG108E | Managed Switch |
| ![tplink](https://cdn.simpleicons.org/tplink?size=32) | TP-Link TL-SG1006PP | PoE Switch powering the Cameras |
