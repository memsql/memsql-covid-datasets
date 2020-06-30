CREATE TABLE IF NOT EXISTS attribute (
    census_block_group TEXT,
    field_id TEXT,
    value BIGINT,

    KEY (census_block_group) USING CLUSTERED COLUMNSTORE,
    KEY (field_id) USING HASH
);

CREATE REFERENCE TABLE IF NOT EXISTS field (
    id TEXT,
    field_full_name TEXT,
    field_level_1 TEXT,
    field_level_2 TEXT,
    field_level_3 TEXT,
    field_level_4 TEXT,
    field_level_5 TEXT,
    field_level_6 TEXT,
    field_level_7 TEXT,
    field_level_8 TEXT,

    PRIMARY KEY (id)
);

CREATE REFERENCE TABLE IF NOT EXISTS fips_codes (
    state TEXT,
    state_fips TEXT,
    county_fips TEXT,
    county TEXT,
    class_code TEXT,

    PRIMARY KEY (state_fips, county_fips)
);

CREATE TABLE IF NOT EXISTS geographic_summary (
    census_block_group TEXT,
    amount_land BIGINT,
    amount_water BIGINT,
    latitude FLOAT,
    longitude FLOAT,

    position AS GEOGRAPHY_POINT(longitude, latitude) PERSISTED GEOGRAPHYPOINT,

    PRIMARY KEY (census_block_group),
    SHARD (census_block_group),
    KEY (position)
);

CREATE TABLE IF NOT EXISTS geometry (
    census_block_group TEXT,
    state TEXT,
    county TEXT,
    shape GEOGRAPHY,

    KEY (census_block_group),
    SHARD (census_block_group),
    KEY (shape)
);
