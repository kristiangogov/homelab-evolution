---
name: Testing
description: Validate this IaC repo - Ansible syntax checks, Terraform fmt/validate, shell script checks, and docker compose config validation. Use when the user asks to test, validate, lint, or verify changes.
---

# Testing

This repo has no test suite or CI. "Testing" means static validation of the
IaC. Run the checks relevant to what changed; run all of them before a commit.

**Prerequisite:** `~/.ansible/vault_pass` must exist, or Ansible checks fail.
All Ansible commands must run from `ansible/` (relative paths in `ansible.cfg`).

## 1. Ansible — syntax check every playbook

```sh
cd ansible
for p in playbooks/*.yaml; do
  ansible-playbook "$p" --syntax-check -e target=production >/dev/null \
    && echo "$p OK" || echo "$p FAIL"
done
```

`-e target=production` satisfies the `vars_prompt` in most playbooks. It does
not connect to any host — this is parse-only.

There is no `ansible-lint` or `yamllint` installed; do not invent those steps.

## 2. Terraform — fmt check + validate per host

Each `terraform/hosts/<node>/` is an independent root and must already be
initialized (`.terraform/` present).

```sh
cd terraform
terraform fmt -check -recursive        # report only; never auto-fix without asking

cd hosts/elitedesk && terraform validate
cd ../thinkcentre && terraform validate
```

`terraform validate` does not contact Proxmox, so it is safe to run. Do not
run `terraform plan`/`apply` as part of testing — plan touches the live lab
and may prompt for credentials.

Known state: `modules/debian/variables.tf` and `modules/fedora/variables.tf`
currently fail `fmt -check` (pre-existing; mention, don't silently reformat).

## 3. Shell scripts

```sh
bash -n scripts/backup_homelab.sh
```

`shellcheck` is not installed; `bash -n` is the available check.

## 4. Compose stacks — config validation

For each changed file under `services/`:

```sh
cd services/<name>
docker compose config -q
```

This is local parsing only; it does not pull images or start containers.
The `homelab` Docker network and `.env` files only exist on target hosts,
so do not try to `docker compose up` stacks locally.

## Out of scope

- No unit/integration tests exist — do not create a test harness unless asked.
- Do not run playbooks against inventory hosts as a "test" (they mutate the lab).
- Do not install new linters unless the user asks.
