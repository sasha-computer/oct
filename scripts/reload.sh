#!/bin/bash
# Build Oct (Release) and relaunch it locally.
set -e

PROJECT_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SCHEME="Oct"
DERIVED_DATA="$PROJECT_ROOT/.build/xcode"

echo "▶ Building $SCHEME..."
xcodebuild \
  -scheme "$SCHEME" \
  -configuration Release \
  -derivedDataPath "$DERIVED_DATA" \
  CODE_SIGN_IDENTITY="-" \
  CODE_SIGNING_REQUIRED=NO \
  CODE_SIGNING_ALLOWED=NO \
  -quiet

APP_PATH=$(find "$DERIVED_DATA" -name "Oct.app" -maxdepth 6 | head -1)

if [ -z "$APP_PATH" ]; then
  echo "✗ Could not find Oct.app in derived data"
  exit 1
fi

echo "▶ Stopping running instance..."
pkill -x "Oct" 2>/dev/null || true
sleep 0.5

echo "▶ Launching $APP_PATH..."
open "$APP_PATH"

echo "✓ Done"
