#!/bin/bash
# Build Oct (Release), sign with dev cert, and relaunch.
set -e

PROJECT_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SCHEME="Oct"
DERIVED_DATA="$PROJECT_ROOT/.build/xcode"
SIGN_IDENTITY="Apple Development: apple@alexanderaldrick.com (WUV342K825)"

echo "▶ Building $SCHEME..."
xcodebuild \
  -scheme "$SCHEME" \
  -configuration Release \
  -derivedDataPath "$DERIVED_DATA" \
  CODE_SIGN_IDENTITY="-" \
  CODE_SIGNING_REQUIRED=NO \
  CODE_SIGNING_ALLOWED=NO \
  -quiet

APP_PATH="$DERIVED_DATA/Build/Products/Release/Oct.app"

if [ ! -d "$APP_PATH" ]; then
  echo "✗ Could not find Oct.app"
  exit 1
fi

echo "▶ Signing with $SIGN_IDENTITY..."
codesign --force --deep --sign "$SIGN_IDENTITY" "$APP_PATH"

echo "▶ Stopping running instance..."
pkill -x "Oct" 2>/dev/null || true
sleep 0.5

echo "▶ Launching $APP_PATH..."
open "$APP_PATH"

echo "✓ Done"
