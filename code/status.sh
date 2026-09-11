#!/usr/bin/env bash
# Reports working-tree and branch state across all repos in this directory.
# Usage: ./status.sh [--fetch]
#   --fetch   run `git fetch` on each repo first (slower, gives accurate ahead/behind counts)

set -uo pipefail
cd "${CODE_DIR:-$HOME/code}"

do_fetch=false
[ "${1:-}" = "--fetch" ] && do_fetch=true

printf "%-45s %-10s %-10s %s\n" "REPO" "BRANCH" "DIRTY" "AHEAD/BEHIND main"
printf "%-45s %-10s %-10s %s\n" "----" "------" "-----" "-----------------"

find . -mindepth 1 -maxdepth 3 -name ".git" -type d 2>/dev/null | sort | while read -r gitdir; do
  repo_dir="$(dirname "$gitdir")"
  repo="${repo_dir#./}"

  $do_fetch && git -C "$repo_dir" fetch --quiet 2>/dev/null

  branch=$(git -C "$repo_dir" rev-parse --abbrev-ref HEAD 2>/dev/null)
  dirty="clean"
  git -C "$repo_dir" diff --quiet --ignore-submodules HEAD -- 2>/dev/null || dirty="DIRTY"
  [ -n "$(git -C "$repo_dir" status --porcelain --untracked-files=no 2>/dev/null)" ] && dirty="DIRTY"

  main_ref=""
  for cand in main master; do
    git -C "$repo_dir" show-ref --verify --quiet "refs/remotes/origin/$cand" && main_ref="origin/$cand" && break
  done

  ab="-"
  if [ -n "$main_ref" ] && [ "$branch" != "${main_ref#origin/}" ]; then
    counts=$(git -C "$repo_dir" rev-list --left-right --count "${main_ref}...HEAD" 2>/dev/null)
    behind=$(echo "$counts" | awk '{print $1}')
    ahead=$(echo "$counts" | awk '{print $2}')
    [ -n "$behind" ] && ab="+${ahead:-0}/-${behind:-0}"
  elif [ -n "$main_ref" ]; then
    behind=$(git -C "$repo_dir" rev-list --count "HEAD..${main_ref}" 2>/dev/null)
    ab="behind by ${behind:-0}"
  fi

  printf "%-45s %-10s %-10s %s\n" "$repo" "${branch:-?}" "$dirty" "$ab"
done
