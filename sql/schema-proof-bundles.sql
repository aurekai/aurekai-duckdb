CREATE TABLE IF NOT EXISTS proof_bundles (
    id BIGINT PRIMARY KEY,
    recipe_name VARCHAR NOT NULL,
    status VARCHAR NOT NULL DEFAULT 'ok',
    operator_id VARCHAR,
    version VARCHAR NOT NULL DEFAULT '0.8.0-alpha.4',
    schema_version VARCHAR NOT NULL DEFAULT 'aurekai.deploy.v1',
    proof_json VARCHAR NOT NULL,
    exported_at TIMESTAMP NOT NULL DEFAULT current_timestamp
);
