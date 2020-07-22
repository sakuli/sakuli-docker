#!/bin/bash
set -e

echo -e "\n\n------------------ CLONE GIT REPOSITORY ---------------------------"
git clone $GIT_URL ${GIT_PATH:-/headless/git-repository}

