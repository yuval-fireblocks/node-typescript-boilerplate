#!/usr/bin/env bash

if [ ! "$1" ]; then
  echo "Usage: bump-version.sh <version> [pre-release]       See 'npm version --help' for version conventions"
  exit 1
fi

if [ -z "$NPM_REGISTRY_URL" ]; then
  NPM_REGISTRY_URL="https://registry.npmjs.org/"
fi

PACKAGE_NAME=$(node -p "require('./package.json').name")
PACKAGE_VERSION=$(node -p "require('./package.json').version")

echo "⏫ Bumping to '$1' version ..."

if [ "$2" ]; then
  NEW_VERSION=$(npm version --no-git-tag-version --preid="$2" "$1") || exit 1
else
  NEW_VERSION=$(npm version --no-git-tag-version "$1") || exit 1
fi

echo "⌗ Bumping to: ${NEW_VERSION}"

echo "⌗ Updating CHANGELOG"
npm i -g auto-changelog
auto-changelog --hide-credit -l 100

echo "📝 Committing to GitHub..."
git fetch
git checkout --track origin/main
git config --global user.email "github-actions@github.com"
git config --global user.name "Github Actions"
git add package.json CHANGELOG.md
git commit --no-verify -m "📦 Release $NEW_VERSION" || exit 1

git push --no-verify || exit 1
echo "🎉 Pushed to GitHub ..."

echo "✅ DONE"
