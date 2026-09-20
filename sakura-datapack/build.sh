#!/usr/bin/env bash
# Pakuje data pack do dist/Sakura-1.20.6.zip (pack.mcmeta w korzeniu archiwum).
set -euo pipefail
cd "$(dirname "$0")"
mkdir -p dist
rm -f dist/Sakura-1.20.6.zip
(cd Sakura && zip -r -q -X ../dist/Sakura-1.20.6.zip pack.mcmeta pack.png data)
echo "Gotowe: $(pwd)/dist/Sakura-1.20.6.zip"
