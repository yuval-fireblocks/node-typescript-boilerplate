#!/usr/bin/env bash

if [ -z "$NPM_REGISTRY_URL" ]; then
  NPM_REGISTRY_URL="https://registry.npmjs.org/"
fi

PACKAGE_NAME=$(node -p "require('./package.json').name")

BOLD='\033[1m'
NORMAL='\033[00m'

if [ "$1" == "--tag" ]; then
  TAG="$2"
  echo -e "🚀 Publishing ${BOLD}$PACKAGE_NAME${NORMAL} with tag "$TAG" to $NPM_REGISTRY_URL\n"
  npm publish --tag "$TAG" --registry $NPM_REGISTRY_URL || exit 1
else
  echo -e "🚀 Publishing ${BOLD}$PACKAGE_NAME${NORMAL} to $NPM_REGISTRY_URL\n"
  npm publish --registry $NPM_REGISTRY_URL || exit 1
fi

echo "🎉 Published to $NPM_REGISTRY_URL ..."
echo "✅ DONE"
