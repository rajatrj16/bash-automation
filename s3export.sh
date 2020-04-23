#!/bin/bash

TIMESTAMP=`date +'%Y%m%d%H%M'`

# to prevent overlapping records, do 16 min ago to 1 min ago

FROMTIME=`date --date="16 minutes ago" +'%Y-%m-%d %H:%M:%S'`

TOTIME=`date --date="1 minutes ago" +'%Y-%m-%d %H:%M:%S'`

# this token needs only audit/activities permission

S3NAME=<folder>-$TIMESTAMP.gz

#S3ACTIVITIESNAME=strongdm-activities-$TIMESTAMP.gz

S3PATH="s3://<bucket/to/path>" # no trailing slash
export AWS_ACCESS_KEY_ID=<XXXXXXXXXXXXXXX>
export AWS_SECRET_ACCESS_KEY=<XXXXXXXXXXXXXXXXXXXXXXXXXXXXX>
# ensure AWS environment variables are in place

journalctl -q -o cat --since "$FROMTIME" --until "$TOTIME" -u sdm-proxy | \
   gzip | aws s3 cp - $S3PATH/$S3NAME

#sdm audit activities --from "$FROMTIME" --to "$TOTIME" | \
#   gzip | aws s3 cp - $S3PATH/$S3ACTIVITIESNAME

