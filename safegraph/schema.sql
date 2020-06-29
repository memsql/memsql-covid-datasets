CREATE DATABASE safegraph;
USE safegraph;

CREATE TABLE places_brand_info (
    safegraph_brand_id TEXT,
    brand_name TEXT,
    parent_safegraph_brand_id TEXT,
    naics_code INT,
    top_category TEXT,
    sub_category TEXT,
    stock_symbol TEXT,
    stock_exchange TEXT,
    PRIMARY KEY (safegraph_brand_id)
);

CREATE TABLE places_poi (
    safegraph_place_id TEXT,
    parent_safegraph_place_id TEXT,
    location_name TEXT,
    safegraph_brand_ids TEXT,
    brands TEXT,
    top_category TEXT,
    sub_category TEXT,
    naics_code INT,
    latitude FLOAT,
    longitude FLOAT,
    street_address TEXT,
    city TEXT,
    region TEXT,
    postal_code TEXT,
    iso_country_code TEXT,
    phone_number TEXT,
    open_hours JSON,
    category_tags TEXT,

    position AS GEOGRAPHY_POINT(longitude, latitude) PERSISTED GEOGRAPHYPOINT,

    PRIMARY KEY (safegraph_place_id),
    KEY (position),
    SHARD (safegraph_place_id)
);

CREATE TABLE places_footprint (
    safegraph_place_id TEXT,
    location_name TEXT,
    polygon_class TEXT,
    is_synthetic TEXT,
    includes_parking_lot TEXT,
    iso_country_code TEXT,
    area_square_feet INT,

    -- TODO: figure out sort key
    KEY (safegraph_place_id) USING CLUSTERED COLUMNSTORE,
    SHARD ()
);

CREATE TABLE places_patterns_monthly (
    safegraph_place_id TEXT,
    location_name TEXT,
    street_address TEXT,
    city TEXT,
    region TEXT,
    postal_code TEXT,
    safegraph_brand_ids TEXT,
    brands TEXT,
    date_range_start DATETIME,
    date_range_end DATETIME,
    raw_visit_counts INT,
    raw_visitor_counts INT,
    visits_by_day JSON,
    poi_cbg TEXT,
    visitor_home_cbgs JSON,
    visitor_daytime_cbgs JSON,
    visitor_work_cbgs JSON,
    visitor_country_of_origin JSON,
    distance_from_home INT,
    median_dwell DOUBLE,
    bucketed_dwell_times JSON,
    related_same_day_brand JSON,
    related_same_month_brand JSON,
    popularity_by_hour JSON,
    popularity_by_day JSON,
    device_type JSON,

    -- TODO: figure out sort key
    KEY (date_range_start) USING CLUSTERED COLUMNSTORE,
    KEY (safegraph_place_id) USING HASH,
    SHARD ()
);

CREATE TABLE IF NOT EXISTS places_patterns_weekly (
    safegraph_place_id TEXT,
    location_name TEXT,
    street_address TEXT,
    city TEXT,
    region TEXT,
    postal_code TEXT,
    iso_country_code TEXT,
    safegraph_brand_ids TEXT,
    brands TEXT,
    date_range_start DATETIME,
    date_range_end DATETIME,
    raw_visit_counts INT,
    raw_visitor_counts INT,
    visits_by_day JSON,
    visits_by_each_hour JSON,
    poi_cbg TEXT,
    visitor_home_cbgs JSON,
    visitor_daytime_cbgs JSON,
    visitor_country_of_origin JSON,
    distance_from_home INT,
    median_dwell DOUBLE,
    bucketed_dwell_times JSON,
    related_same_day_brand JSON,
    related_same_week_brand JSON,
    device_type JSON,

    -- TODO: figure out sort key
    KEY (date_range_start) USING CLUSTERED COLUMNSTORE,
    KEY (safegraph_place_id) USING HASH,
    SHARD ()
);

CREATE TABLE social_distancing (
    origin_census_block_group TEXT,
    date_range_start DATETIME,
    date_range_end DATETIME,
    device_count INT,
    distance_traveled_from_home INT,
    bucketed_distance_traveled JSON,
    median_dwell_at_bucketed_distance_traveled JSON,
    completely_home_device_count INT,
    median_home_dwell_time INT,
    bucketed_home_dwell_time JSON,
    at_home_by_each_hour JSON,
    part_time_work_behavior_devices INT,
    full_time_work_behavior_devices INT,
    destination_cbgs JSON,
    delivery_behavior_devices INT,
    median_non_home_dwell_time INT,
    candidate_device_count INT,
    bucketed_away_from_home_time JSON,
    median_percentage_time_home INT,
    bucketed_percentage_time_home JSON,
    mean_home_dwell_time INT,
    mean_non_home_dwell_time INT,
    mean_distance_traveled_from_home INT,

    -- TODO: figure out sort key
    KEY (date_range_start) USING CLUSTERED COLUMNSTORE,
    KEY (origin_census_block_group) USING HASH,
    SHARD ()
);

CREATE TABLE tx_daily_deposits_zip (
    day DATETIME,
    zip TEXT,
    num_cards INT,
    num_transactions INT,
    total_spend DECIMAL(13,2),

    KEY (day) USING CLUSTERED COLUMNSTORE,
    KEY (zip) USING HASH,
    SHARD ()
);

CREATE TABLE tx_daily_spend_brand (
    day DATETIME,
    merchant_name TEXT,
    safegraph_brand_id TEXT,
    zip TEXT,
    num_cards INT,
    num_transactions INT,
    total_spend DECIMAL(13,2),

    KEY (day) USING CLUSTERED COLUMNSTORE,
    KEY (zip) USING HASH,
    SHARD ()
);

CREATE TABLE tx_daily_spend_walmart (
    day DATETIME,
    zip TEXT,
    num_cards INT,
    num_transactions INT,
    total_spend DECIMAL(13,2),

    KEY (day) USING CLUSTERED COLUMNSTORE,
    KEY (zip) USING HASH,
    SHARD ()
);

CREATE TABLE tx_daily_spend_zip_mcc (
    day DATETIME,
    mcc TEXT,
    zip TEXT,
    num_cards INT,
    num_transactions INT,
    total_spend DECIMAL(13,2),

    KEY (day) USING CLUSTERED COLUMNSTORE,
    KEY (zip) USING HASH,
    SHARD ()
);

CREATE TABLE tx_daily_spend_zip (
    day DATETIME,
    zip TEXT,
    num_cards INT,
    num_transactions INT,
    total_spend DECIMAL(13,2),

    KEY (day) USING CLUSTERED COLUMNSTORE,
    KEY (zip) USING HASH,
    SHARD ()
);
