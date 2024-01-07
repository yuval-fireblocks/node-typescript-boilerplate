#!/usr/bin/env bash

if [ ! "$1" ]; then
  echo "Usage: bump-version.sh <version>       See 'npm version --help' for version conventions"
  exit 1
fi

if [ ! "$2" ]; then
  echo "Branch name is missing"
  exit 1
fi

if [ -z "$NPM_REGISTRY_URL" ]; then
  NPM_REGISTRY_URL="https://registry.npmjs.org/"
fi

PACKAGE_NAME=$(node -p "require('./package.json').name")
PACKAGE_VERSION=$(node -p "require('./package.json').version")

echo "⏫ Bumping to '$1' version ..."

CURRENT_VERSION=$(npm view --registry $NPM_REGISTRY_URL ${PACKAGE_NAME}@latest version > /dev/null || echo "$PACKAGE_VERSION")
echo "⌗ Current version: $CURRENT_VERSION"

NEW_VERSION=$(npm version --no-git-tag-version "$1") || exit 1
echo "⌗ Bumping to: ${NEW_VERSION}"

echo "⌗ Updating CHANGELOG"
npm i -g auto-changelog
auto-changelog --hide-credit -l 100
echo "export const SDK_VERSION = '$(echo "${NEW_VERSION}" | sed 's/^v//')'" > src/version.ts

echo "📝 Committing to GitHub..."
git fetch
git config --global user.email "github-actions@github.com"
git config --global user.name "Github Actions"
git add package.json CHANGELOG.md src/version.ts
git commit --no-verify -m "📦 Release $NEW_VERSION" || exit 1

git push origin/$2 --no-verify || exit 1
echo "🎉 Pushed to GitHub ..."
# echo "🎉 dry run. branch $current_branch version $NEW_VERSION"

echo "✅ DONE"