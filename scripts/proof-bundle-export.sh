#!/usr/bin/env bash
set -euo pipefail
DB="${1:?Usage: proof-bundle-export.sh <db_path> [out_dir]}"
OUT="${2:-out}"
mkdir -p "$OUT"
python3 - <<PY
import duckdb, json
con=duckdb.connect("$DB")
rows=con.execute("SELECT id, recipe_name, status, operator_id, version, schema_version, proof_json, exported_at FROM proof_bundles ORDER BY exported_at DESC").fetchall()
out=[]
for r in rows:
    out.append({"id":r[0],"recipe_name":r[1],"status":r[2],"operator_id":r[3],"version":r[4],"schema_version":r[5],"proof":json.loads(r[6]),"exported_at":str(r[7])})
with open("$OUT/proof-bundle.json","w",encoding="utf-8") as f:
    json.dump({"status":"ok","count":len(out),"bundles":out},f,indent=2)
print("[proof-bundle-export] PASS")
PY
