CREATE TABLE IF NOT EXISTS sae_dictionaries (
    id BIGINT PRIMARY KEY,
    artifact_name VARCHAR NOT NULL,
    artifact_ext VARCHAR NOT NULL,
    operator_id VARCHAR,
    version VARCHAR NOT NULL DEFAULT '0.8.0-alpha.4',
    schema_version VARCHAR NOT NULL DEFAULT 'aurekai.deploy.v1',
    layer_index INTEGER,
    feature_count INTEGER,
    size_bytes BIGINT,
    sha256 VARCHAR,
    payload BLOB,
    created_at TIMESTAMP NOT NULL DEFAULT current_timestamp,
    updated_at TIMESTAMP NOT NULL DEFAULT current_timestamp
);
