#!/usr/bin/env bash
set -euo pipefail
DB="${1:?Usage: manifest-verify.sh <db_path> <name> <version>}"
NAME="${2:?name required}"
VER="${3:?version required}"
c=$(duckdb -csv "$DB" -c "SELECT count(*) FROM manifests WHERE name='$NAME' AND version='$VER' AND schema_version='aurekai.deploy.v1';" | tail -1)
[ "$c" -ge 1 ] || { echo "manifest not found" >&2; exit 1; }
echo "[manifest-verify] PASS"
