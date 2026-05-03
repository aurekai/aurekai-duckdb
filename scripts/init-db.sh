#!/usr/bin/env bash
set -euo pipefail
DB="${1:?Usage: init-db.sh <db_path>}"
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
for s in schema-model-memory.sql schema-sae.sql schema-semantic-cache.sql schema-manifests.sql schema-proof-bundles.sql; do
  duckdb "$DB" < "$ROOT/sql/$s"
done
echo "[init-db] PASS"
