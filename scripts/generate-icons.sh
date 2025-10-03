#!/bin/bash

# Generate App Icons Script
# This script creates all required iOS, iPadOS, and macOS app icon sizes from a master 1024x1024 icon

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
APPICON_DIR="$PROJECT_DIR/Sources/Assets.xcassets/AppIcon.appiconset"

# Master icon (look for any 1024x1024 icon)
MASTER_ICON=""
for icon in "$APPICON_DIR"/*.png; do
    if [ -f "$icon" ]; then
        # Check if it's 1024x1024
        WIDTH=$(sips -g pixelWidth "$icon" | tail -1 | awk '{print $2}')
        HEIGHT=$(sips -g pixelHeight "$icon" | tail -1 | awk '{print $2}')
        if [ "$WIDTH" = "1024" ] && [ "$HEIGHT" = "1024" ]; then
            MASTER_ICON="$icon"
            break
        fi
    fi
done

if [ -z "$MASTER_ICON" ] || [ ! -f "$MASTER_ICON" ]; then
    echo "❌ No 1024x1024 master icon found in: $APPICON_DIR"
    echo "💡 Please add a 1024x1024 PNG file to the AppIcon.appiconset folder first"
    echo "📁 Current files:"
    ls -la "$APPICON_DIR"
    exit 1
fi

echo "🎨 Generating app icons from: $MASTER_ICON"
echo "📁 Output directory: $APPICON_DIR"

# Clean up existing icons (but keep any existing master)
cd "$APPICON_DIR"
# Don't remove all PNGs, just make a copy of master for processing
cp "$MASTER_ICON" "master-icon-temp.png"

# Function to generate icon
generate_icon() {
    local size=$1
    local filename=$2
    local pixels="${size}x${size}"
    
    echo "  📱 Generating ${filename} (${pixels})"
    sips -z $size $size "master-icon-temp.png" --out "$filename" > /dev/null 2>&1
}

echo "🔨 Generating iPhone icons..."
# iPhone icons
generate_icon 40 "icon-20@2x.png"       # 20pt @2x
generate_icon 60 "icon-20@3x.png"       # 20pt @3x
generate_icon 58 "icon-29@2x.png"       # 29pt @2x  
generate_icon 87 "icon-29@3x.png"       # 29pt @3x
generate_icon 80 "icon-40@2x.png"       # 40pt @2x
generate_icon 120 "icon-40@3x.png"      # 40pt @3x
generate_icon 120 "icon-60@2x.png"      # 60pt @2x
generate_icon 180 "icon-60@3x.png"      # 60pt @3x

echo "📱 Generating iPad icons..."
# iPad icons
generate_icon 20 "icon-20.png"          # 20pt @1x
generate_icon 40 "icon-20@2x-ipad.png"  # 20pt @2x
generate_icon 29 "icon-29.png"          # 29pt @1x
generate_icon 58 "icon-29@2x-ipad.png"  # 29pt @2x
generate_icon 40 "icon-40.png"          # 40pt @1x
generate_icon 80 "icon-40@2x-ipad.png"  # 40pt @2x
generate_icon 76 "icon-76.png"          # 76pt @1x
generate_icon 152 "icon-76@2x.png"      # 76pt @2x
generate_icon 167 "icon-83.5@2x.png"    # 83.5pt @2x (iPad Pro)

echo "💻 Generating Mac Catalyst icons..."
# Mac Catalyst icons (for Mac Catalyst apps)
generate_icon 16 "icon-16-mac.png"      # 16pt @1x
generate_icon 32 "icon-16@2x-mac.png"   # 16pt @2x
generate_icon 32 "icon-32-mac.png"      # 32pt @1x
generate_icon 64 "icon-32@2x-mac.png"   # 32pt @2x
generate_icon 128 "icon-128-mac.png"    # 128pt @1x
generate_icon 256 "icon-128@2x-mac.png" # 128pt @2x
generate_icon 256 "icon-256-mac.png"    # 256pt @1x
generate_icon 512 "icon-256@2x-mac.png" # 256pt @2x
generate_icon 512 "icon-512-mac.png"    # 512pt @1x
generate_icon 1024 "icon-512@2x-mac.png" # 512pt @2x

echo "🏪 Generating App Store icon..."
# App Store
generate_icon 1024 "icon-1024.png"      # App Store (iOS Marketing)

# Clean up
rm -f "master-icon-temp.png"

echo "✅ Icon generation complete!"
echo ""
echo "� Summary:"
ICON_COUNT=$(ls -1 *.png | grep -v "master-icon" | wc -l)
echo "  📱 iPhone icons: 8 files"
echo "  📱 iPad icons: 9 files"
echo "  💻 Mac Catalyst icons: 10 files"
echo "  🏪 App Store icon: 1 file"
echo "  � Total generated: $ICON_COUNT icon files"
echo ""
echo "�📋 Next steps:"
echo "  1. Open Xcode and go to Assets.xcassets → AppIcon"
echo "  2. The icons should now display properly for all platforms"
echo "  3. Build your project to test: make build (iOS) or make macos-build (Mac)"
echo ""
echo "💡 If icons still don't appear in Xcode, try:"
echo "  - Clean build folder (Cmd+Shift+K)"
echo "  - Restart Xcode"
echo "  - Run: make setup (to regenerate project)"
