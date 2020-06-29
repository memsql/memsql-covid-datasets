#!/usr/bin/env bash
set -eux

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
S3URL="s3://sg-c19-response/core/2020/06/Core-USA-June2020-Release-CORE_POI-2020_05-2020-06-06.zip"

export AWS_ACCESS_KEY_ID=${SAFEGRAPH_ACCESS_KEY}
export AWS_SECRET_ACCESS_KEY=${SAFEGRAPH_SECRET_KEY}

cd "${SCRIPTPATH}"

mkdir -p core-places
aws --endpoint https://s3.wasabisys.com s3 cp ${S3URL} core-places/

cd core-places
unzip Core-USA-June2020-Release-CORE_POI-2020_05-2020-06-06.zip
