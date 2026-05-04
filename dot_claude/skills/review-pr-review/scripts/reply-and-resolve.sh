#!/bin/bash
# Usage: reply-and-resolve.sh REPO PR_NUMBER COMMENT_ID THREAD_ID BODY
# Example: reply-and-resolve.sh aiiro-systems/sake-api 117 3160530704 PRRT_kwDOEQ4Fps5-aPuS "対応しない理由"
set -euo pipefail

if [ $# -ne 5 ]; then
  echo "Usage: $0 REPO PR_NUMBER COMMENT_ID THREAD_ID BODY" >&2
  exit 1
fi

repo="$1"
pr_number="$2"
comment_id="$3"
thread_id="$4"
body="$5"

gh api "repos/$repo/pulls/$pr_number/comments/$comment_id/replies" -f body="$body" --silent

gh api graphql -f query="mutation { resolveReviewThread(input: {threadId: \"$thread_id\"}) { thread { id isResolved } } }" --silent

echo "Replied and resolved: $thread_id"
