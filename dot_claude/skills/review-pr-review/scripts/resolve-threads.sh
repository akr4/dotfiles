#!/bin/bash
# Usage: resolve-threads.sh THREAD_ID1 THREAD_ID2 ...
set -euo pipefail

if [ $# -eq 0 ]; then
  echo "Usage: $0 THREAD_ID [THREAD_ID ...]" >&2
  exit 1
fi

resolved=0
failed=0

for thread_id in "$@"; do
  result=$(gh api graphql -f query="mutation { resolveReviewThread(input: {threadId: \"$thread_id\"}) { thread { id isResolved } } }" 2>&1) || {
    echo "FAILED: $thread_id" >&2
    failed=$((failed + 1))
    continue
  }
  resolved=$((resolved + 1))
done

echo "Resolved: $resolved, Failed: $failed"
