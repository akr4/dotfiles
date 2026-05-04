#!/bin/bash
# Usage: fetch-review-threads.sh OWNER/REPO PR_NUMBER [--unresolved]
set -euo pipefail

if [ $# -lt 2 ]; then
  echo "Usage: $0 OWNER/REPO PR_NUMBER [--unresolved]" >&2
  exit 1
fi

owner=$(echo "$1" | cut -d/ -f1)
repo=$(echo "$1" | cut -d/ -f2)
pr_number="$2"
filter="${3:-}"

query='query($owner: String!, $repo: String!, $number: Int!) {
  repository(owner: $owner, name: $repo) {
    pullRequest(number: $number) {
      title
      url
      reviewThreads(first: 100) {
        nodes {
          id
          isResolved
          isOutdated
          comments(first: 10) {
            nodes {
              id
              databaseId
              body
              author { login }
              path
              line
              startLine
              createdAt
            }
          }
        }
      }
    }
  }
}'

result=$(gh api graphql \
  -f query="$query" \
  -F owner="$owner" \
  -F repo="$repo" \
  -F number="$pr_number")

if [ "$filter" = "--unresolved" ]; then
  echo "$result" | jq '.data.repository.pullRequest | {
    title,
    url,
    threads: [.reviewThreads.nodes[] | select(.isResolved == false)]
  }'
else
  echo "$result" | jq '.data.repository.pullRequest | {
    title,
    url,
    threads: .reviewThreads.nodes
  }'
fi
