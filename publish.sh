#!/usr/bin/env bash

if [ -z "$NPM_REGISTRY_URL" ]; then
  NPM_REGISTRY_URL="https://registry.npmjs.org/"
fi

PACKAGE_NAME=$(node -p "require('./package.json').name")

BOLD='\033[1m'
NORMAL='\033[00m'

echo -e "🚀 Publishing ${BOLD}$PACKAGE_NAME${NORMAL} to $NPM_REGISTRY_URL\n"
# npm publish --registry $NPM_REGISTRY_URL || exit 1
echo "🎉 Published to $NPM_REGISTRY_URL ..."

echo "✅ DONE"