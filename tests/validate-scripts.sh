#!/usr/bin/env bash
set -euo pipefail
DB="${1:-/tmp/aurekai-duckdb-validate.db}"
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
rm -f "$DB"
bash "$ROOT/scripts/init-db.sh" "$DB"
duckdb "$DB" -c "INSERT INTO manifests VALUES (1,'aurekai.deploy.v1','aurekai','0.8.0-alpha.4',89,'git:1ba1f19','0.8.1','0.8.0a3','0.8.0-alpha.4','0.8.0-alpha.3','{}',current_timestamp);"
duckdb "$DB" -c "INSERT INTO sae_dictionaries VALUES (1,'test.aksae','.aksae',NULL,'0.8.0-alpha.4','aurekai.deploy.v1',0,512,1024,'deadbeef',NULL,current_timestamp,current_timestamp);"
duckdb "$DB" -c "INSERT INTO proof_bundles VALUES (1,'r.json','ok',NULL,'0.8.0-alpha.4','aurekai.deploy.v1','{\"status\":\"ok\"}',current_timestamp);"
duckdb "$DB" -c "INSERT INTO model_memory VALUES (1,'m.akmodel','.akmodel',NULL,'0.8.0-alpha.4','aurekai.deploy.v1',1024,'bead',NULL,current_timestamp,current_timestamp);"
bash "$ROOT/scripts/manifest-verify.sh" "$DB" aurekai 0.8.0-alpha.4
bash "$ROOT/scripts/sae-audit.sh" "$DB"
bash "$ROOT/scripts/semantic-cache-bench.sh" "$DB" 50
bash "$ROOT/scripts/proof-bundle-export.sh" "$DB" /tmp/aurekai-duckdb-out
bash "$ROOT/scripts/release-gate.sh" "$DB"
test -f /tmp/aurekai-duckdb-out/proof-bundle.json
echo "[validate-scripts] PASS"
