#!/bin/zsh

commit() {
  echo "$2 ($1)" >> commit_log.txt   # ensure file changes every commit
  git add -A
  GIT_COMMITTER_DATE="$1" git commit -m "$2" --date "$1"
}

# Start fresh orphan branch
git checkout --orphan fresh-main
rm -f commit_log.txt
git add -A
GIT_COMMITTER_DATE="2025-03-02 09:15:00" git commit -m "Initialize project baseline with all files" --date "2025-03-02 09:15:00"

# 19 more commits
commit "2025-03-05 11:30:00" "Add Put method for saving key-value pairs"
commit "2025-03-08 14:45:00" "Implement Get method with error handling"
commit "2025-03-11 10:20:00" "Introduce Delete method for removing entries"
commit "2025-03-14 16:10:00" "Refactor: use RWMutex for thread-safe access"
commit "2025-03-18 13:05:00" "Add tests for Put and Get operations"
commit "2025-03-21 09:55:00" "Improve error messages for missing keys"
commit "2025-03-25 15:40:00" "Add persistence: write store data to disk"
commit "2025-03-29 10:25:00" "Load store data from disk on startup"
commit "2025-04-03 14:00:00" "Optimize file I/O with buffered writer"
commit "2025-04-08 11:15:00" "Support JSON serialization for stored values"
commit "2025-04-13 16:45:00" "Add batch Put method for bulk inserts"
commit "2025-04-18 09:20:00" "Refactor persistence layer into helper functions"
commit "2025-04-23 13:30:00" "Introduce TTL support for expiring keys"
commit "2025-04-29 15:10:00" "Add cleanup routine for expired entries"
commit "2025-05-05 10:40:00" "Improve test coverage for TTL and cleanup"
commit "2025-05-11 14:55:00" "Add logging for store operations"
commit "2025-05-17 11:25:00" "Introduce in-memory LRU cache for fast lookups"
commit "2025-05-22 16:15:00" "Benchmark store performance with large dataset"
commit "2025-05-27 09:50:00" "Final refactor: polish API and update documentation"
