#!/usr/bin/env bash
# Resize and recompress everything in images/. The old site served full-size
# uploads, some of them multi-megabyte. Requires ImageMagick.
#
#   brew install imagemagick   # macOS
#   bash scripts/optimize-images.sh

set -euo pipefail
command -v magick >/dev/null || { echo "ImageMagick not found"; exit 1; }

echo "Team photos to 600px wide"
find images/team -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' \) \
  -exec magick {} -resize '600x>' -quality 82 -strip {} \;

echo "Research images to 1400px wide"
find images/research -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' \) \
  -exec magick {} -resize '1400x>' -quality 82 -strip {} \;

echo
du -sh images/
