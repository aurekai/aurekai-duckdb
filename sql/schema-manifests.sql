CREATE TABLE IF NOT EXISTS manifests (
    id BIGINT PRIMARY KEY,
    schema_version VARCHAR NOT NULL DEFAULT 'aurekai.deploy.v1',
    name VARCHAR NOT NULL,
    version VARCHAR NOT NULL,
    operator_count INTEGER,
    runtime_ref VARCHAR,
    helm_chart_ver VARCHAR,
    pypi_ver VARCHAR,
    npm_ver VARCHAR,
    jsr_ver VARCHAR,
    raw_json VARCHAR NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT current_timestamp
);
