#!/usr/bin/env bash
set -euo pipefail
DB="${1:?Usage: model-memory-pack.sh <db_path> <artifact_path> [operator_id]}"
ART="${2:?artifact path required}"
OP="${3:-}"
[ -f "$ART" ] || { echo "artifact not found" >&2; exit 1; }
NAME=$(basename "$ART")
EXT=".${ART##*.}"
SIZE=$(wc -c < "$ART" | tr -d ' ')
SHA=$(shasum -a 256 "$ART" | awk '{print $1}')
if [ -n "$OP" ]; then OVAL="'$OP'"; else OVAL="NULL"; fi
duckdb "$DB" -c "INSERT INTO model_memory VALUES (COALESCE((SELECT max(id)+1 FROM model_memory),1), '$NAME', '$EXT', $OVAL, '0.8.0-alpha.4', 'aurekai.deploy.v1', $SIZE, '$SHA', read_blob('$ART'), current_timestamp, current_timestamp);"
echo "[model-memory-pack] PASS"
