#!/bin/bash

# GitHub API endpoint
API_URL="https://api.github.com"

# Your GitHub personal access token
TOKEN="<PASS YOU PAT TOKEN HERE WITH APPROPRIATE PERMISSION TO LIST ALL REPOS>"

# GitHub organization
ORGANIZATION="<ORGANIZATION NAME>"

# Output file
OUTPUT_FILE="allrepos.json"

# Page size (max 100)
PER_PAGE=100

# Initialize page number
PAGE=1

# Clear output file
> "${OUTPUT_FILE}"

while true; do
  # Construct API request URL
  URL="${API_URL}/orgs/${ORGANIZATION}/repos?per_page=${PER_PAGE}&page=${PAGE}&type=all"

  # Make API request using curl
  RESPONSE=$(curl -s -X GET \
    ${URL} \
    -H "Authorization: Bearer ${TOKEN}" \
    -H "Accept: application/json")

  # Check if response is empty
  if [ -z "${RESPONSE}" ]; then
    break
  fi

  # Extract repository URLs using jq and append to output file
  jq -r '.[] | .git_url' <<< "${RESPONSE}" >> "${OUTPUT_FILE}"

  # Increment page number
  ((PAGE++))
done

echo "Repository URLs saved to ${OUTPUT_FILE}"