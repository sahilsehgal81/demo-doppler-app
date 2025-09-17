#!/bin/sh
sleep 10
# URL to check
URL="http://localhost:80"

# Expected response substring
EXPECTED_RESPONSE="Development deploy"

# Perform the curl request and store the response
RESPONSE=$(curl -s $URL)

# Check if the response contains the expected substring
echo "$RESPONSE" | grep -q "$EXPECTED_RESPONSE"
if [ $? -eq 0 ]; then
  echo "URL check passed: Response contains '$RESPONSE'"
else
  # Log alert message to the log file with a timestamp
  echo "Application Test failed"
  exit 1
fi

