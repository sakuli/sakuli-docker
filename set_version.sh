#!/usr/bin/env bash

NEW_SAKULI_VERSION=${1}
[[ -z "${NEW_SAKULI_VERSION}" ]]  && echo "No Sakuli version given." && exit 1

echo "New version to set is ${NEW_SAKULI_VERSION}."
NEW_SAKULI_VERSION_MATCHER=$(echo ${NEW_SAKULI_VERSION} | sed "s/\./\\\./g")

CURRENT_SAKULI_VERSION=$(grep "ARG SAKULI_VERSION=" Dockerfile.sakuli-ubuntu-openbox | cut -d "=" -f2 | sed "s/\./\\\./g")
FILES_TO_UPDATE=$(find . -type f ! -path "./.idea/*"  ! -path "./.git/*" ! -path "./**/node_modules/*")
sed -i "s/${CURRENT_SAKULI_VERSION}/${NEW_SAKULI_VERSION_MATCHER}/g" ${FILES_TO_UPDATE}

echo ""
echo "Files modified:"
echo "$(git diff --name-only)"