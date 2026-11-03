#!/usr/bin/env bash
set -e

timestamp=$(date +%Y-%m-%d_%H-%M-%S)

# Backup databases

echo "Backing up PostgreSQL Database."

ssh server@production "
  mkdir -p /mnt/nas_backup/homelab/postgres

  docker exec postgres pg_dump -U docmost docmost \
    > /mnt/nas_backup/homelab/postgres/docmost-${timestamp}.sql

  docker exec postgres pg_dump -U infisical infisical \
    > /mnt/nas_backup/homelab/postgres/infisical-${timestamp}.sql
"

echo "Database backups complete."
