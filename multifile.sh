#!/bin/bash

# Process files in "in" and send them to "out", zipped.
# Upload the resulting files to the S3_BUCKET and S3_PREFIX specified

if [[ "$S3_BUCKET" == '' || "$S3_KEY" == '' ]]; then
  upload_s3() {
    aws s3 cp "$1" "s3://$S3_BUCKET/$2"
  }
else
  echo 'No S3_BUCKET or S3_KEY env vars set so not uploading to s3'
  upload_s3() {
  }
fi

panic() {
  echo 'Something went wrong!' >&1
  exit 1
}

process_file() {
  f="$1"
  OUT="out/$(uuidgen).json"
  ZIPPED="$OUT.gz"
  S3_KEY="$S3_PREFIX/$(basename $OUT)"

  ./csv_to_json.py "$f" "$OUT" || panic
  gzip "$OUT" || panic
  upload_s3 "$ZIPPED" "$S3_KEY" || panic
}

for f in $(ls -1 in); do process_file "$f" done
