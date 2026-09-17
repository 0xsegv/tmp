#!/usr/bin/env bash

set -e

BRANCH=$(git branch --show-current)

if [ -z "$BRANCH" ]; then
    echo "Error: not on a branch."
    exit 1
fi

echo "Cleaning Git history on branch: $BRANCH"

# Make sure everything currently in the working tree is included
git add -A

# Create a temporary orphan branch with no history
git checkout --orphan clean-temp

# Commit the current state as the only commit
git commit -m "Clean repository"

# Replace the old branch
git branch -D "$BRANCH"
git branch -m "$BRANCH"

# Force-push the new history to GitHub
git push --force origin "$BRANCH"

echo "Done. GitHub now has only the new commit."
