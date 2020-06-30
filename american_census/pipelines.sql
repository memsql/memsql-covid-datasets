CREATE OR REPLACE PIPELINE attribute
AS LOAD DATA S3 'memsql-american-census/census_demographic'
CONFIG '{"region": "us-east-1"}'
INTO TABLE attribute;

START PIPELINE attribute;

CREATE OR REPLACE PIPELINE field
AS LOAD DATA S3 'memsql-american-census/metadata/cbg_field_descriptions.csv.gz'
CONFIG '{"region": "us-east-1"}'
INTO TABLE attribute
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
NULL DEFINED BY '' OPTIONALLY ENCLOSED
IGNORE 1 LINES;

START PIPELINE field;

CREATE OR REPLACE PIPELINE fips_codes
AS LOAD DATA S3 'memsql-american-census/metadata/cbg_fips_codes.csv.gz'
CONFIG '{"region": "us-east-1"}'
INTO TABLE attribute
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
NULL DEFINED BY '' OPTIONALLY ENCLOSED
IGNORE 1 LINES;

START PIPELINE fips_codes;

CREATE OR REPLACE PIPELINE geographic_summary
AS LOAD DATA S3 'memsql-american-census/metadata/cbg_geographic_data.csv.gz'
CONFIG '{"region": "us-east-1"}'
INTO TABLE attribute
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
NULL DEFINED BY '' OPTIONALLY ENCLOSED
IGNORE 1 LINES;

START PIPELINE geographic_summary;

CREATE OR REPLACE PIPELINE geometry
AS LOAD DATA S3 'memsql-american-census/cbg_geometry.tsv.gz'
CONFIG '{"region": "us-east-1"}'
INTO TABLE geometry;

START PIPELINE geometry;
