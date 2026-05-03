# Quickstart

1. Install dependencies

python3 -m pip install -r requirements.txt

2. Initialize database

bash scripts/init-db.sh /tmp/aurekai-duckdb.db

3. Run checks

bash tests/validate-schemas.sh /tmp/aurekai-duckdb.db
bash tests/validate-scripts.sh /tmp/aurekai-duckdb.db
