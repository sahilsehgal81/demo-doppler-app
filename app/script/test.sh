#!/bin/sh
sleep 10
# URL to check
URL="http://localhost:80"

# Perform the curl request and get HTTP status code
STATUS_CODE=$(curl -s -o /dev/null -w "%{http_code}" $URL)

if [ "$STATUS_CODE" -eq 200 ]; then
  echo "Health check passed: $URL returned $STATUS_CODE"
else
  echo "Health check failed: $URL returned $STATUS_CODE"
  exit 1
fi
