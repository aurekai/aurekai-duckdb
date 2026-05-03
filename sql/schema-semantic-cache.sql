CREATE TABLE IF NOT EXISTS semantic_cache (
    id BIGINT PRIMARY KEY,
    cache_key VARCHAR NOT NULL UNIQUE,
    embedding BLOB,
    value VARCHAR NOT NULL,
    hit_count BIGINT NOT NULL DEFAULT 0,
    version VARCHAR NOT NULL DEFAULT '0.8.0-alpha.4',
    expires_at TIMESTAMP,
    created_at TIMESTAMP NOT NULL DEFAULT current_timestamp,
    updated_at TIMESTAMP NOT NULL DEFAULT current_timestamp
);
