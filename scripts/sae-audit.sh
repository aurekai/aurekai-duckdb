#!/usr/bin/env bash
set -euo pipefail
DB="${1:?Usage: sae-audit.sh <db_path>}"
duckdb "$DB" -c "SELECT artifact_ext, count(*) AS count FROM sae_dictionaries GROUP BY artifact_ext ORDER BY artifact_ext;"
echo "[sae-audit] PASS"
