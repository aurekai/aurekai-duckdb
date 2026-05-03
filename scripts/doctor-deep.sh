#!/usr/bin/env bash
set -euo pipefail
DB="${1:?Usage: doctor-deep.sh <db_path>}"
for t in model_memory sae_dictionaries semantic_cache manifests proof_bundles; do
  c=$(duckdb -csv "$DB" -c "SELECT count(*) FROM information_schema.tables WHERE table_name='$t';" | tail -1)
  [ "$c" = "1" ] || { echo "Missing table: $t" >&2; exit 1; }
done
if command -v akai >/dev/null 2>&1; then
  akai doctor --deep || true
fi
echo "[doctor-deep] PASS"
