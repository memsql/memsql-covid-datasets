#!/usr/bin/env bash
set -eu

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
cd "${SCRIPTPATH}"

# load brand info
cat <<EOF
LOAD DATA LOCAL INFILE '$PWD/core-places/brand_info.csv'
INTO TABLE places_brand_info
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
IGNORE 1 LINES;
EOF

for poifile in $(ls core-places | grep core_poi); do
cat <<EOF

LOAD DATA LOCAL INFILE '${PWD}/core-places/${poifile}'
INTO TABLE places_poi
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
NULL DEFINED BY ''
IGNORE 1 LINES;
EOF
done
