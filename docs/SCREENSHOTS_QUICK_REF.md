# App Store Screenshots - Quick Reference

## Required Screenshot Sizes (October 2025)

### iPhone (Portrait Orientation)

| Size | Resolution | Priority | Example Devices |
|------|-----------|----------|-----------------|
| 6.9" | **1320 × 2868** | ⭐ Required | iPhone 16 Pro Max, 15 Pro Max |
| 6.7" | **1290 × 2796** | ⭐ Required | iPhone 16 Plus, 15 Plus |
| 6.1" | **1179 × 2556** | ⭐ Required | iPhone 16 Pro, 15 Pro, 14 Pro |
| 6.5" | **1242 × 2688** | Optional | iPhone 11 Pro Max, XS Max |
| 5.5" | **1242 × 2208** | Legacy | iPhone 8 Plus, 7 Plus |

### iPad (Portrait or Landscape)

| Size | Resolution | Priority | Devices |
|------|-----------|----------|---------|
| 12.9" | **2048 × 2732** | ⭐ Required | iPad Pro 12.9" (all generations) |
| 11" | **1668 × 2388** | ⭐ Required | iPad Pro 11", iPad Air 4th gen+ |

### macOS (Landscape Orientation)

| Size | Resolution | Priority | Use Case |
|------|-----------|----------|----------|
| Retina | **2880 × 1800** | ⭐ Required | Modern Macs (recommended) |
| Standard | **1280 × 800** | Fallback | Minimum supported |

---

## Quick Start

### 1. Capture Screenshots

```bash
# iPhone/iPad Simulator
make run SIM=iphone17pro    # For iPhone screenshots
make run SIM=ipad           # For iPad screenshots

# macOS
make macos-run              # For macOS screenshots

# Physical Device
make dev-run                # iPhone
make dev-run DEVICE=ipad    # iPad
```

**Capture Methods:**
- **Simulator**: Press `⌘ + S` (saves to Desktop)
- **Physical Device**: Press `Volume Up + Side Button` (saves to Photos)
- **macOS**: Press `⌘ + Shift + 4`, then `Space`, click window

### 2. Organize Screenshots

```bash
# Create directory structure
mkdir -p screenshots/originals

# Move screenshots with proper naming
cp ~/Desktop/screenshot1.png screenshots/originals/iphone_home.png
cp ~/Desktop/screenshot2.png screenshots/originals/ipad_library.png
cp ~/Desktop/screenshot3.png screenshots/originals/macos_settings.png
```

**Naming Convention:**
- iPhone: `*iphone*.png` (e.g., `iphone_home.png`)
- iPad: `*ipad*.png` (e.g., `ipad_search.png`)
- macOS: `*macos*.png` or `*mac*.png` (e.g., `macos_main.png`)

### 3. Resize Screenshots

```bash
# Install ImageMagick (recommended for best quality)
brew install imagemagick

# Run resize script
./scripts/resize-screenshots.sh

# Or with custom directories
./scripts/resize-screenshots.sh ~/Desktop/screenshots ./output
```

### 4. Upload to App Store Connect

1. Visit: <https://appstoreconnect.apple.com>
2. Select your app
3. Go to "App Store" → Your Version
4. Upload screenshots from `screenshots/appstore/` directories
5. Arrange in desired order (first screenshot is primary)

---

## Screenshot Content Recommendations

### Required Screenshots (Minimum 3 per device size)

1. **Home/Search Screen** - Show main interface and primary feature
2. **Search Results** - Demonstrate AI-powered document search
3. **Library View** - Show document management interface
4. **Insights/History** - Display advanced features
5. **Settings** - Highlight privacy and customization options

### Best Practices

✅ **DO:**
- Use actual app interface (not mockups)
- Show real functionality with realistic data
- Ensure text is clear and readable
- Test both light and dark mode
- Order by importance (first screenshot is most visible)

❌ **DON'T:**
- Use placeholder or dummy content
- Include debug information or overlays
- Stretch or distort images
- Use blurry or low-quality images
- Show competitor apps or offensive content

---

## Common Commands

### Check Screenshot Dimensions

```bash
# Single file
sips -g pixelWidth -g pixelHeight screenshot.png

# All files in directory
for file in screenshots/appstore/iPhone/6.9-inch/*.png; do
  echo "$file"
  sips -g pixelWidth -g pixelHeight "$file" | grep pixel
done
```

### Manual Resize (if needed)

```bash
# Using ImageMagick (best quality)
magick input.png -resize 1320x2868 -gravity center \
  -background white -extent 1320x2868 output.png

# Using sips (built-in)
sips -z 2868 1320 input.png --out output.png
```

### Optimize File Sizes

```bash
# Install optimizer
brew install optipng

# Optimize PNG files
optipng -o7 screenshots/appstore/**/*.png
```

---

## Script Options

### Basic Usage

```bash
# Default directories (./screenshots/originals → ./screenshots/appstore)
./scripts/resize-screenshots.sh

# Custom directories
./scripts/resize-screenshots.sh [source_dir] [output_dir]

# Show help
./scripts/resize-screenshots.sh --help
```

### Output Structure

```
screenshots/appstore/
├── iPhone/
│   ├── 6.9-inch/       # 1320 × 2868
│   ├── 6.7-inch/       # 1290 × 2796
│   ├── 6.5-inch/       # 1242 × 2688
│   ├── 6.1-inch/       # 1179 × 2556
│   └── 5.5-inch/       # 1242 × 2208
├── iPad/
│   ├── 12.9-inch/      # 2048 × 2732
│   └── 11-inch/        # 1668 × 2388
└── macOS/              # 2880 × 1800
```

---

## Troubleshooting

### Issue: Script can't find screenshots

**Solution:** Check naming convention
```bash
# Must include platform name in filename
✓ iphone_home.png
✓ iPhone_search.png
✓ my_iphone_app.png
✗ home.png
✗ screenshot1.png
```

### Issue: Screenshots appear stretched

**Solution:** Use "fit" mode (default) which adds padding
- Script automatically maintains aspect ratio
- Adds white padding if needed
- Source images should be similar aspect ratio to target

### Issue: Poor quality output

**Solution:** Use high-quality source images
```bash
# Install ImageMagick for better resizing
brew install imagemagick

# Start with highest resolution available
# Capture at 3x scale on simulator if possible
```

---

## Requirements Checklist

Before uploading to App Store Connect:

- [ ] Captured screenshots on correct devices/simulators
- [ ] Named files with platform identifier (iphone/ipad/macos)
- [ ] Ran resize script successfully
- [ ] Verified dimensions match requirements
- [ ] Checked image quality (no blur or distortion)
- [ ] Prepared 3-10 screenshots per device size
- [ ] Ordered screenshots by importance
- [ ] Used actual app data (not placeholders)
- [ ] Removed debug information
- [ ] File sizes under 5MB each
- [ ] All screenshots use PNG format

---

## Additional Resources

- **Full Documentation**: [docs/APP_STORE_SCREENSHOTS.md](./APP_STORE_SCREENSHOTS.md)
- **Apple Guidelines**: <https://developer.apple.com/app-store/marketing/guidelines/>
- **App Store Connect**: <https://appstoreconnect.apple.com>
- **Icon Setup**: [docs/APP_ICON_SETUP.md](./APP_ICON_SETUP.md)

---

**Quick Tips:**

💡 Focus on iPhone 6.9", 6.7", and 6.1" for maximum device coverage  
💡 Use PNG format for best quality  
💡 Keep file sizes under 5MB  
💡 First screenshot appears in search results - make it count!  
💡 Create separate sets for light and dark mode if needed  

**Last Updated**: October 3, 2025
