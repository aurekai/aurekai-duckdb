<p align="center">
  <img src="https://raw.githubusercontent.com/aurekai/aurekai/main/assets/aurekai-logo.svg" alt="Aurekai" width="520" />
</p>

# aurekai-duckdb

Aurekai integration surface for DuckDB - embedded analytical data-ml storage for model memory, SAE dictionaries, semantic cache, manifests, and proof bundles.

Status: active
Type: data-ml

## Overview

`aurekai-duckdb` provides DuckDB schemas and scripts for local and edge analytics workflows where zero-ops deployment and vectorized query performance are needed.

## Core Template Set

| Template | Description |
|---|---|
| doctor-deep | Validate DuckDB connectivity, schema integrity, and optional akai doctor |
| manifest-verify | Verify aurekai.deploy.v1 manifest records |
| model-memory-pack | Insert model memory artifacts and payloads |
| sae-audit | Audit SAE dictionary rows and integrity |
| semantic-cache-bench | Run semantic cache write/read benchmark |
| proof-bundle-export | Export proof bundle rows to JSON |
| release-gate | Enforce release readiness checks |

## Quick Start

```bash
python3 -m pip install -r requirements.txt
bash scripts/init-db.sh /tmp/aurekai-duckdb.db
bash scripts/doctor-deep.sh /tmp/aurekai-duckdb.db
bash scripts/release-gate.sh /tmp/aurekai-duckdb.db
```

## Canonical References

- Platform: https://github.com/aurekai/aurekai
- Native runtime: https://github.com/aurekai/native-runtime
- Integration registry: https://github.com/aurekai/aurekai/blob/main/registry/integrations.json
- Ecosystem map: https://github.com/aurekai/aurekai/blob/main/ECOSYSTEM_NAMES.md
