#!/usr/bin/env bash
set -euo pipefail
DB="${1:?Usage: release-gate.sh <db_path>}"
fail=0
for t in model_memory sae_dictionaries semantic_cache manifests proof_bundles; do
  c=$(duckdb -csv "$DB" -c "SELECT count(*) FROM $t;" | tail -1)
  if [ "$c" -gt 0 ]; then
    echo "PASS $t: $c"
  else
    echo "FAIL $t empty" >&2
    fail=1
  fi
done
m=$(duckdb -csv "$DB" -c "SELECT count(*) FROM manifests WHERE schema_version!='aurekai.deploy.v1';" | tail -1)
[ "$m" -eq 0 ] || fail=1
p=$(duckdb -csv "$DB" -c "SELECT count(*) FROM proof_bundles WHERE status='fail';" | tail -1)
[ "$p" -eq 0 ] || fail=1
[ "$fail" -eq 0 ] || { echo "[release-gate] FAIL" >&2; exit 1; }
echo "[release-gate] PASS"
