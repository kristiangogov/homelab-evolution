# Homelab Evolution

A Proxmox-based homelab designed for reliably self-hosting services along with experimenting with new technologies via disposable VM environments. The setup is heavily focused on Infrastructure-as-Code and automation.

## Overview

Three Proxmox nodes run the workloads, and a dedicated NAS provides bulk storage.

- **Stable stack:** long-lived services run as Docker Compose stacks in VMs.
- **Experiments:** new tech is tried in disposable VMs and destroyed afterwards. Nothing in the stable set depends on them.
- **Storage split:**
  - *Local:* latency-sensitive or node-bound state, such as Frigate recordings or SQLite dependant applications.
  - *NAS:* bulk and shared data, such as the Jellyfin media library.
- **Everything is code:** VMs and stacks are defined declaratively and reproducible from the repo.

## Status

| Area | State |
|------|-------|
| Ansible Proxmox initial config | Initial test done |
| Terraform VM provisioning | Initial test done |
| Ansible Docker Compose deploy | Initial test done |
| Migration from bare-metal server | Docmost instance tested and DB Restored successfully |
| Kubernetes | After Compose stack is fully migrated |

## Hardware

#### Compute
| Logo | Device | Specs | Role |
|-|-|-|-|
| ![HP](https://cdn.simpleicons.org/hp?size=32) | HP EliteDesk 800 G2 SFF [1] |i5-6500 8GB RAM| NAS |
| ![HP](https://cdn.simpleicons.org/hp?size=32) | HP EliteDesk 800 G2 SFF [2] |i5-6500 8GB RAM |  Proxmox Node |
| ![Lenovo](https://cdn.simpleicons.org/lenovo?size=32) | Lenovo Thinkcentre M700 |i3-6100T 16GB RAM| Proxmox Node |
| ![Lenovo](https://cdn.simpleicons.org/lenovo?size=32) | Lenovo Thinkpad T14 | i7-10610U 32GB RAM | Proxmox Node |

