# AGENTS.md

Homelab IaC repo: Ansible (host config + compose deploys), Terraform (Proxmox VMs), Docker Compose stacks. No application code, no CI, no test suite.

## Layout1

- `ansible/` — playbooks, roles, inventory. All shared vars in `ansible/inventory/group_vars/all/` (`main.yaml` has NAS mounts/IP, `vault.yaml` is Ansible Vault encrypted).
- `terraform/hosts/<node>/` — one independent Terraform root per Proxmox node (`elitedesk`, `thinkcentre`), each with its own state. Shared logic in `terraform/modules/`.
- `services/<name>/` — compose stack source. Deployed to `/opt/homelab/<name>/` on the target VM, not run from the repo.
- `scripts/` — ad-hoc shell helpers (e.g. `backup_homelab.sh`, a manual DB/config backup over SSH).

## Ansible

- Run from `ansible/`: `ansible.cfg` uses relative paths (`inventory = ./inventory/hosts.ini`, `roles_path = ./roles`), so running from the repo root silently uses the wrong/no inventory.
- Vault password file must exist at `~/.ansible/vault_pass` or every playbook run fails.
- Most playbooks prompt for `target`. Skip the prompt with extra vars: `ansible-playbook playbooks/deploy.yaml -e target=production -e service=kaneo`.
- `playbooks/deploy.yaml` (role `compose-deploy`) requires `-e service=<name>`:
  - Copies `services/<name>/` → `/opt/homelab/<name>/`, then `docker compose up -d --remove-orphans`.
  - Loads optional `services/<name>/vars.yaml` (e.g. `mosquitto`) for ownership (`service_owner_uid/gid`).
  - It does **not** create `.env` files (`*.env` is gitignored) nor the external `homelab` Docker network — both must already exist on the target or the stack fails to start.
- `playbooks/teardown.yaml` runs `docker compose down` on every compose project found under `/opt/homelab` (depth 2).
- Inventory: `[proxmox]` = bare nodes (root), `[virtual_machines]` = `production` (192.168.0.10) and `dev` (192.168.0.51), user `server`.
- Roles use FQCN (`ansible.builtin.*`, `ansible.posix.*`); NFS mounts use `ansible.posix.mount` with `_netdev,x-systemd.automount`.

## Terraform

- Always `cd terraform/hosts/<node>` first — state and `terraform.tfvars` are per-host and not shared.
- `terraform.tfvars` holds real secrets (Proxmox token, cloud-init password) and is gitignored; `terraform.tfvars.example` is the tracked template.
- A VM is only created if its name appears in `enabled_vms`; defining it in `vms` alone does nothing.
- Validate with `terraform fmt` / `terraform validate` inside the host dir. There is no CI — nothing validates for you automatically.

## Conventions

- Commit style: conventional prefixes (`feat:`, `fix:`, `refactor:`, `docs:`).
- NAS is reached via NFS mounts defined in `group_vars/all/main.yaml` (`/mnt/nas_backup` etc.); the `nfs-mount` role sets them up.
- Backup strategy is being reworked (see README status); `scripts/backup_homelab.sh` reflects the old approach — check whether it still matches reality before extending it.
