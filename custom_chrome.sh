#!/bin/sh
if [ -z "$1" ]; then
  echo "Usage: $0 profile_name"
  exit 1
fi
PROFILE_NAME="$1"
GOOGLE_CHROME="$HOME/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
USER_DIR="$HOME/Library/Application Support/Google/Chrome/${PROFILE_NAME}"

exec "$GOOGLE_CHROME" \
  --enable-udd-profiles \
  --user-data-dir="$USER_DIR"
