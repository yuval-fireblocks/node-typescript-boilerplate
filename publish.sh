#!/usr/bin/env bash

if [ -z "$NPM_REGISTRY_URL" ]; then
  NPM_REGISTRY_URL="https://registry.npmjs.org/"
fi
if [ -z "$1" ]; then
  # Default tag if not provided
  TAG="latest"
else
  TAG="$1"
fi
PACKAGE_NAME=$(node -p "require('./package.json').name")

BOLD='\033[1m'
NORMAL='\033[00m'

echo -e "🚀 Publishing ${BOLD}$PACKAGE_NAME${NORMAL} to $NPM_REGISTRY_URL\n"
npm publish --tag "$TAG" --registry $NPM_REGISTRY_URL || exit 1

echo "🎉 Published to $NPM_REGISTRY_URL ..."
echo "✅ DONE"
