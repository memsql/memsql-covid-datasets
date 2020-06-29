CREATE OR REPLACE PIPELINE places_footprint AS
LOAD DATA S3 'sg-c19-response/geo-supplement/May2020Release/SafeGraphPlacesGeoSupplementSquareFeet.csv.gz'
CONFIG '{"endpoint_url": "https://s3.wasabisys.com", "region": "us-east-1"}'
CREDENTIALS '{"aws_access_key_id": "${SAFEGRAPH_ACCESS_KEY}", "aws_secret_access_key": "${SAFEGRAPH_SECRET_KEY}"}'
INTO TABLE places_footprint
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
NULL DEFINED BY '' OPTIONALLY ENCLOSED
IGNORE 1 LINES;

CREATE OR REPLACE PIPELINE places_patterns_monthly AS
LOAD DATA S3 'sg-c19-response/monthly-patterns/patterns'
CONFIG '{"endpoint_url": "https://s3.wasabisys.com", "region": "us-east-1"}'
CREDENTIALS '{"aws_access_key_id": "${SAFEGRAPH_ACCESS_KEY}", "aws_secret_access_key": "${SAFEGRAPH_SECRET_KEY}"}'
INTO TABLE places_patterns_monthly
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
NULL DEFINED BY '' OPTIONALLY ENCLOSED
IGNORE 1 LINES;

CREATE OR REPLACE PIPELINE places_patterns_weekly_old AS
LOAD DATA S3 'sg-c19-response/weekly-patterns/v2/main-file/'
CONFIG '{"endpoint_url": "https://s3.wasabisys.com", "region": "us-east-1"}'
CREDENTIALS '{"aws_access_key_id": "${SAFEGRAPH_ACCESS_KEY}", "aws_secret_access_key": "${SAFEGRAPH_SECRET_KEY}"}'
INTO TABLE places_patterns_weekly
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
NULL DEFINED BY '' OPTIONALLY ENCLOSED
IGNORE 1 LINES;

CREATE OR REPLACE PIPELINE places_patterns_weekly_new AS
LOAD DATA S3 'sg-c19-response/weekly-patterns-delivery/weekly/patterns/'
CONFIG '{"endpoint_url": "https://s3.wasabisys.com", "region": "us-east-1"}'
CREDENTIALS '{"aws_access_key_id": "${SAFEGRAPH_ACCESS_KEY}", "aws_secret_access_key": "${SAFEGRAPH_SECRET_KEY}"}'
INTO TABLE places_patterns_weekly
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
NULL DEFINED BY '' OPTIONALLY ENCLOSED
IGNORE 1 LINES;

CREATE OR REPLACE PIPELINE social_distancing AS
LOAD DATA S3 'sg-c19-response/social-distancing/v2/'
CONFIG '{"endpoint_url": "https://s3.wasabisys.com", "region": "us-east-1"}'
CREDENTIALS '{"aws_access_key_id": "${SAFEGRAPH_ACCESS_KEY}", "aws_secret_access_key": "${SAFEGRAPH_SECRET_KEY}"}'
INTO TABLE social_distancing
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
NULL DEFINED BY '' OPTIONALLY ENCLOSED
IGNORE 1 LINES;

CREATE OR REPLACE PIPELINE tx_daily_deposits_zip AS
LOAD DATA S3 'sg-c19-response/transactions-facteus/cut-5-daily-federal-deposits-by-zip/'
CONFIG '{"endpoint_url": "https://s3.wasabisys.com", "region": "us-east-1"}'
CREDENTIALS '{"aws_access_key_id": "${SAFEGRAPH_ACCESS_KEY}", "aws_secret_access_key": "${SAFEGRAPH_SECRET_KEY}"}'
INTO TABLE tx_daily_deposits_zip
FIELDS TERMINATED BY ','
NULL DEFINED BY '' OPTIONALLY ENCLOSED
IGNORE 1 LINES;

CREATE OR REPLACE PIPELINE tx_daily_spend_brand AS
LOAD DATA S3 'sg-c19-response/transactions-facteus/cut-3-daily-spend-by-brand/'
CONFIG '{"endpoint_url": "https://s3.wasabisys.com", "region": "us-east-1"}'
CREDENTIALS '{"aws_access_key_id": "${SAFEGRAPH_ACCESS_KEY}", "aws_secret_access_key": "${SAFEGRAPH_SECRET_KEY}"}'
INTO TABLE tx_daily_spend_brand
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
NULL DEFINED BY '' OPTIONALLY ENCLOSED;

CREATE OR REPLACE PIPELINE tx_daily_spend_walmart AS
LOAD DATA S3 'sg-c19-response/transactions-facteus/cut-4-daily-spend-at-walmart/'
CONFIG '{"endpoint_url": "https://s3.wasabisys.com", "region": "us-east-1"}'
CREDENTIALS '{"aws_access_key_id": "${SAFEGRAPH_ACCESS_KEY}", "aws_secret_access_key": "${SAFEGRAPH_SECRET_KEY}"}'
INTO TABLE tx_daily_spend_walmart
FIELDS TERMINATED BY '|'
NULL DEFINED BY '' OPTIONALLY ENCLOSED;

CREATE OR REPLACE PIPELINE tx_daily_spend_zip_mcc AS
LOAD DATA S3 'sg-c19-response/transactions-facteus/cut-2-daily-spend-by-zip-by-mcc/'
CONFIG '{"endpoint_url": "https://s3.wasabisys.com", "region": "us-east-1"}'
CREDENTIALS '{"aws_access_key_id": "${SAFEGRAPH_ACCESS_KEY}", "aws_secret_access_key": "${SAFEGRAPH_SECRET_KEY}"}'
INTO TABLE tx_daily_spend_zip_mcc
FIELDS TERMINATED BY ','
NULL DEFINED BY '' OPTIONALLY ENCLOSED;

CREATE OR REPLACE PIPELINE tx_daily_spend_zip AS
LOAD DATA S3 'sg-c19-response/transactions-facteus/cut-1-daily-spend-by-zip/'
CONFIG '{"endpoint_url": "https://s3.wasabisys.com", "region": "us-east-1"}'
CREDENTIALS '{"aws_access_key_id": "${SAFEGRAPH_ACCESS_KEY}", "aws_secret_access_key": "${SAFEGRAPH_SECRET_KEY}"}'
INTO TABLE tx_daily_spend_zip
FIELDS TERMINATED BY ','
NULL DEFINED BY '' OPTIONALLY ENCLOSED
IGNORE 1 LINES;

START ALL PIPELINES;
