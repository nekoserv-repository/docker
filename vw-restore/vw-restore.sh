#!/bin/sh

## checking all required environment variables
missing_env=""
for name in AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_PROFILE AWS_REGION BUCKET DESTINATION PASSWORD; do
    if [ -z "$(eval echo \$$name)" ]; then
        [ -z "${missing_env}" ] && missing_env="${name}" || missing_env="${missing_env}, ${name}"
    fi
done

## exit if at least one env. var is missing
if [ ! -z "${missing_env}" ]; then
  echo "[!] environment variables not set: ${missing_env}"
  exit 1
fi

## work in a temp directory
cd $(mktemp -d)

## find last backup
echo -e "[~] searching for the last backup"
last_backup=$(s5cmd ls s3://${BUCKET}/ | awk '{print($4)}' | sort -rn | head -n1)
echo -e "[~] found ${last_backup}"

## fetch last backup
echo -e "[~] downloading ${last_backup}"
s5cmd --log error cp s3://${BUCKET}/${last_backup} .

## unzip encrypted backup
echo -e "[~] extracting files"
unzip -P ${PASSWORD} backup.*.zip

## extract tar files
for f in $(ls *.tar); do tar xf $f; done

## remove ZIP and TAR files
rm *.zip *.tar

## rename config.json and db.sqlite
mv config.*.json config.json
mv db.*.sqlite3 db.sqlite3

## copy files to destination
echo -e "[~] copy files to destination"
cp -a * ${DESTINATION}

## remove temp directory
echo -e "[~] cleanup"
cd && rm -rf /tmp/tmp.*
