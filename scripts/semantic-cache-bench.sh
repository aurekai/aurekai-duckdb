#!/usr/bin/env bash
set -euo pipefail
DB="${1:?Usage: semantic-cache-bench.sh <db_path> [iterations]}"
N="${2:-500}"
python3 - <<PY
import duckdb, hashlib, random, string, time
con = duckdb.connect("$DB")
n = int("$N")
t0=time.perf_counter()
for i in range(n):
    k=hashlib.sha256(f"k{i}".encode()).hexdigest()
    v=''.join(random.choices(string.ascii_lowercase,k=40))
    con.execute(
        """
        INSERT INTO semantic_cache (id, cache_key, value, version, created_at, updated_at)
        VALUES (coalesce((SELECT max(id)+1 FROM semantic_cache),1), ?, ?, '0.8.0-alpha.4', now(), now())
        ON CONFLICT(cache_key) DO UPDATE SET
            value = excluded.value,
            updated_at = now()
        """,
        [k, v],
    )
t1=time.perf_counter()
h=0
t2=time.perf_counter()
for i in range(n):
    k=hashlib.sha256(f"k{i}".encode()).hexdigest()
    r=con.execute("SELECT value FROM semantic_cache WHERE cache_key=?",[k]).fetchone()
    if r: h+=1
t3=time.perf_counter()
print(f"Writes: {n} in {(t1-t0)*1000:.1f}ms")
print(f"Reads: {h}/{n} in {(t3-t2)*1000:.1f}ms")
print("[semantic-cache-bench] PASS")
PY
