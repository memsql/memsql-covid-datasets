# MemSQL + SafeGraph
This directory contains all of the scripts & assets you needed to quickly get
started with importing SafeGraph data into your MemSQL cluster.

# Requirements

## Access to a MemSQL cluster
The easiest way to get started with loading this data is either via MemSQL Free
Edition or MemSQL Helios. You can learn more about each of these options at the
following website: http://memsql.com/free.

Alternatively, for individuals or organizations who need more than what our free
edition can offer, MemSQL offers non-commercial licenses and free Helios usage
for qualified projects. For more information about this program please reach out
to us via the contact form at http://memsql.org/.

## SafeGraph Data Access
The scripts in this particular folder require an active account with SafeGraph.
Specifically, these schema's and pipeline statements are designed to be used
with the data provided through the SafeGraph COVID-19 Data Consortium. To join
this program please apply here: https://www.safegraph.com/covid-19-data-consortium

# Cluster Sizing
If you want to load the entire dataset, ensure that your MemSQL cluster has a
minimum of 600 GB of disk space and at least 8 GB of available RAM.  This
dataset fits within MemSQL Free Edition's usage limits.

# Load Data

The following instructions make the following assumptions:

* MemSQL is running on your machine with host `127.0.0.1`, port `3306`, user
  `root` and no password
* You have exported your SafeGraph access key and secret key in your shell
  environment named like so:
  ```bash
  export SAFEGRAPH_ACCESS_KEY="***********************"
  export SAFEGRAPH_SECRET_KEY="***********************"
  ```

## Setup the schema and start loading data

> Note the following commands requires the `envsubst` program to be installed

```bash
cat schema.sql | memsql -u root -h 127.0.0.1 -P 3306
cat pipelines.sql | envsubst | memsql -u root -h 127.0.0.1 -P 3306 safegraph
```

## Core Places (POI)
The core-places dataset can't be loaded by MemSQL Pipelines directly, and must
be first downloaded and unpacked on your machine. This directory includes a
couple scripts which will do this for you. They require the AWS CLI to be
installed.

```bash
./core-places-download.sh
./core-places-load.sh | memsql -u root -h 127.0.0.1 -P 3306 safegraph
```
