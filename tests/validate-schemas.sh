#!/usr/bin/env bash
set -euo pipefail
DB="${1:-/tmp/aurekai-duckdb-validate.db}"
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
rm -f "$DB"
bash "$ROOT/scripts/init-db.sh" "$DB"
for t in model_memory sae_dictionaries semantic_cache manifests proof_bundles; do
  c=$(duckdb -csv "$DB" -c "SELECT count(*) FROM information_schema.tables WHERE table_name='$t';" | tail -1)
  [ "$c" = "1" ] || exit 1
done
echo "[validate-schemas] PASS"
