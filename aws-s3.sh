#/bin/bash

DATE=$(date +%H:%M:%S_%Y-%m-%d)
BACKUP_FILE=dump-$DATE.gz
DB_HOST=$1
DB_USERNAME=$2
DB_PASSWORD=$3
AWS_KEY_ID=$4
AWS_ACCESS_KEY=$5
AWS_BUCKET_NAME=$6

mongodump -u $DB_USERNAME -h $DB_HOST -p $DB_PASSWORD --gzip --archive > /tmp/$BACKUP_FILE && \
export AWS_ACCESS_KEY_ID=$AWS_KEY_ID && \
export AWS_SECRET_ACCESS_KEY=$AWS_ACCESS_KEY && \
echo "Uploading your backup || s3://$AWS_BUCKET_NAME/$BACKUP_FILE"
