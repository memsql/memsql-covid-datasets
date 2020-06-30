# Open Census Data
This directory contains all of the scripts & assets you needed to quickly get
started with importing census data into your MemSQL cluster.

This data is based on the work by SafeGraph. You can retrieve their original
dataset here: https://www.safegraph.com/open-census-data

# Load Data

The following examples require setting these environment variables:

```bash
# Your MemSQL cluster connection details
export MEMSQL_HOST="127.0.0.1"
export MEMSQL_PORT="3306"
export MEMSQL_USER="root"
export MEMSQL_PASS=""
export MEMSQL_DB="census"
```

## Create the database

```bash
memsql -h ${MEMSQL_HOST} -P ${MEMSQL_PORT} \
       -u ${MEMSQL_USER} -p${MEMSQL_PASS} \
       -e "CREATE DATABASE ${MEMSQL_DB}"
```

## Setup the schema and start loading data

```bash
cat schema.sql | memsql -h ${MEMSQL_HOST} -P ${MEMSQL_PORT} -u ${MEMSQL_USER} -p${MEMSQL_PASS} ${MEMSQL_DB}
cat pipelines.sql | memsql -h ${MEMSQL_HOST} -P ${MEMSQL_PORT} -u ${MEMSQL_USER} -p${MEMSQL_PASS} ${MEMSQL_DB}
```
