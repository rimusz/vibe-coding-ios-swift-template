# App Store Screenshots Guide

Complete guide for creating, resizing, and uploading screenshots for your iOS/iPadOS/macOS app to the Apple App Store.

## Table of Contents

- [Overview](#overview)
- [Screenshot Requirements](#screenshot-requirements)
- [Device Sizes](#device-sizes)
- [Quick Start](#quick-start)
- [Detailed Instructions](#detailed-instructions)
- [Best Practices](#best-practices)
- [Troubleshooting](#troubleshooting)
- [Tools](#tools)

## Overview

Apple App Store Connect requires specific screenshot dimensions for each device type. This guide helps you:

1. **Capture** screenshots at the correct sizes
2. **Resize** existing screenshots to meet requirements
3. **Organize** screenshots for easy uploading
4. **Optimize** screenshots for maximum impact

## Screenshot Requirements

### General Requirements

- **Format**: PNG (recommended) or JPEG
- **Color Space**: RGB (no CMYK)
- **Transparency**: Not allowed (use solid backgrounds)
- **Quantity**: 3-10 screenshots per device size
- **Priority**: At least one device size required per platform

### Quality Guidelines

- **Resolution**: Use highest quality source images
- **Content**: Show actual app functionality
- **Text**: Avoid small text (must be readable)
- **UI**: Show real UI, not mockups
- **Localization**: Create separate sets for each language

## Device Sizes

### iPhone (iOS 18+ Required)

| Display Size | Resolution | Devices | Priority | Directory |
|-------------|-----------|---------|----------|-----------|
| **6.9"** | 1320 × 2868 | iPhone 16 Pro Max, 15 Pro Max, 14 Pro Max | **Required** | `iPhone/6.9-inch/` |
| **6.7"** | 1290 × 2796 | iPhone 16 Plus, 15 Plus, 14 Plus | **Required** | `iPhone/6.7-inch/` |
| **6.5"** | 1242 × 2688 | iPhone 11 Pro Max, XS Max | Optional | `iPhone/6.5-inch/` |
| **6.1"** | 1179 × 2556 | iPhone 16 Pro, 15 Pro, 14 Pro, 13, 12 | **Required** | `iPhone/6.1-inch/` |
| **5.5"** | 1242 × 2208 | iPhone 8 Plus, 7 Plus, 6s Plus | Legacy | `iPhone/5.5-inch/` |

**Note**: Focus on 6.9", 6.7", and 6.1" for maximum coverage of modern devices.

### iPad

| Display Size | Resolution | Devices | Priority | Directory |
|-------------|-----------|---------|----------|-----------|
| **12.9"** | 2048 × 2732 | iPad Pro 12.9" (all gens) | **Required** | `iPad/12.9-inch/` |
| **11"** | 1668 × 2388 | iPad Pro 11", iPad Air (4th gen+) | **Required** | `iPad/11-inch/` |

### macOS (Mac Catalyst)

| Display Size | Resolution | Use Case | Priority | Directory |
|-------------|-----------|----------|----------|-----------|
| **Retina** | 2880 × 1800 | Retina MacBook Pro, iMac | **Required** | `macOS/` |
| **Standard** | 1280 × 800 | Minimum supported | Fallback | `macOS/` |

**Note**: 2880×1800 is strongly recommended for modern Macs.

## Quick Start

### Prerequisites

```bash
# Install ImageMagick (recommended for best quality)
brew install imagemagick

# sips is built-in on macOS, no installation needed
```

### 1. Prepare Source Screenshots

Create a directory structure:

```bash
mkdir -p screenshots/originals
```

Add your screenshots with naming conventions:

```bash
screenshots/originals/
├── iphone_home.png           # iPhone screenshots
├── iphone_search.png
├── iphone_settings.png
├── ipad_home.png             # iPad screenshots
├── ipad_library.png
├── macos_main.png            # macOS screenshots
└── macos_settings.png
```

**Naming Conventions**:
- iPhone: `*iphone*.png` or `*iPhone*.png`
- iPad: `*ipad*.png` or `*iPad*.png`
- macOS: `*macos*.png`, `*macOS*.png`, or `*mac*.png`

### 2. Run Resize Script

```bash
# Make script executable
chmod +x scripts/resize-screenshots.sh

# Run with default directories
./scripts/resize-screenshots.sh

# Or specify custom directories
./scripts/resize-screenshots.sh ~/Desktop/screenshots ./output
```

### 3. Review Output

The script creates organized directories:

```
screenshots/appstore/
├── iPhone/
│   ├── 6.9-inch/
│   │   ├── iphone_home_6.9inch.png
│   │   ├── iphone_search_6.9inch.png
│   │   └── iphone_settings_6.9inch.png
│   ├── 6.7-inch/
│   ├── 6.5-inch/
│   ├── 6.1-inch/
│   └── 5.5-inch/
├── iPad/
│   ├── 12.9-inch/
│   └── 11-inch/
└── macOS/
    ├── macos_main_macos.png
    └── macos_settings_macos.png
```

## Detailed Instructions

### Capturing Screenshots

#### iPhone/iPad (Physical Device or Simulator)

**Using Physical Device:**

1. Run app on device: `make dev-run` (iPhone) or `make dev-run DEVICE=ipad` (iPad)
2. Navigate to the screen you want to capture
3. Press **Volume Up + Side Button** simultaneously
4. Screenshots saved to Photos app
5. AirDrop to Mac or sync via iCloud Photos

**Using Simulator:**

1. Run app in simulator: `make run SIM=iphone17pro` or `make run SIM=ipad`
2. Navigate to the screen you want to capture
3. Press **⌘ + S** (Command + S) to save screenshot
4. Screenshots saved to Desktop by default
5. Move to `screenshots/originals/` directory

**Tips for Best Results:**
- Use iPhone 16 Pro Max simulator for 6.9" screenshots (best quality)
- Use iPad Pro 12.9" simulator for iPad screenshots
- Capture in light mode and dark mode (create separate sets)
- Show different features in each screenshot

#### macOS (Mac Catalyst)

1. Run app on macOS: `make macos-run`
2. Resize window to desired size (recommended: 2880×1800)
3. Navigate to the screen you want to capture
4. Use one of these methods:
   - **Full Window**: Press **⌘ + Shift + 4**, then press **Space**, click window
   - **Selection**: Press **⌘ + Shift + 4**, drag to select area
   - **Built-in**: Screenshot app (press **⌘ + Shift + 5**)
5. Screenshots saved to Desktop
6. Move to `screenshots/originals/` directory

### Resizing Screenshots

#### Automatic Resizing (Recommended)

Use the provided script:

```bash
./scripts/resize-screenshots.sh
```

The script will:
- ✅ Detect source images by naming pattern
- ✅ Create all required sizes automatically
- ✅ Maintain aspect ratio (adds padding if needed)
- ✅ Optimize quality
- ✅ Organize output by device size

#### Manual Resizing

If you prefer manual control:

**Using Preview (macOS built-in):**

1. Open screenshot in Preview
2. Tools → Adjust Size
3. Set dimensions (e.g., 1320 × 2868 for iPhone 6.9")
4. Uncheck "Scale proportionally" if needed
5. Save As → PNG format

**Using ImageMagick:**

```bash
# Resize and pad to exact dimensions
magick input.png -resize 1320x2868 -gravity center \
  -background white -extent 1320x2868 output.png

# Batch process
for file in *.png; do
  magick "$file" -resize 1320x2868 -gravity center \
    -background white -extent 1320x2868 "resized_$file"
done
```

**Using sips (macOS built-in):**

```bash
# Resize maintaining aspect ratio
sips -Z 2868 input.png --out output.png

# Resize to exact dimensions (may distort)
sips -z 2868 1320 input.png --out output.png
```

### Uploading to App Store Connect

1. **Navigate to App Store Connect**
   - Visit: https://appstoreconnect.apple.com
   - Select your app
   - Go to "App Store" tab
   - Select version (e.g., 1.0.2)

2. **Upload Screenshots by Device**
   
   **For iPhone:**
   - Click "iPhone 6.9\" Display" section
   - Drag and drop screenshots from `screenshots/appstore/iPhone/6.9-inch/`
   - Arrange in desired order (first screenshot is primary)
   - Repeat for other iPhone sizes
   
   **For iPad:**
   - Click "iPad Pro (6th Gen) 12.9\" Display" section
   - Drag and drop screenshots from `screenshots/appstore/iPad/12.9-inch/`
   - Repeat for 11" display
   
   **For macOS:**
   - Click "macOS" section
   - Drag and drop screenshots from `screenshots/appstore/macOS/`

3. **Order Screenshots**
   - First screenshot appears in search results
   - Order by importance: Home → Main Features → Settings
   - Consistent order across all device sizes

4. **Save Changes**
   - Click "Save" button
   - Review all screenshots before submitting

## Best Practices

### Screenshot Content

#### What to Show

✅ **DO:**
- Actual app interface (not mockups)
- Key features and functionality
- Realistic data and content
- Clear, readable text
- Professional appearance
- App in action (search, results, settings)

❌ **DON'T:**
- Placeholder or dummy content
- Debug information or overlays
- Stretched or distorted images
- Blurry or low-quality images
- Competitor mentions
- Offensive content

### Screenshot Composition

#### 1. Home/Landing Screen
- Show main interface
- Demonstrate primary value proposition
- Include clear call-to-action

#### 2. Key Feature Screens
- Document search functionality
- AI-powered results
- Library management
- Search history

#### 3. Settings/Configuration
- Privacy controls
- Appearance options
- Premium features

### Screenshot Order

**Recommended order for 5 screenshots:**

1. **Home/Search** - Primary feature, what users see first
2. **Search Results** - Show AI capabilities in action
3. **Library View** - Document management interface
4. **Insights/History** - Advanced features
5. **Settings** - Customization and privacy controls

### Localization

If supporting multiple languages:

```bash
# Create language-specific directories
screenshots/originals/
├── en-US/          # English (US)
├── es-ES/          # Spanish
├── fr-FR/          # French
└── de-DE/          # German
```

Run resize script for each language:

```bash
./scripts/resize-screenshots.sh screenshots/originals/en-US screenshots/appstore/en-US
./scripts/resize-screenshots.sh screenshots/originals/es-ES screenshots/appstore/es-ES
```

## Troubleshooting

### Common Issues

#### Issue: "Screenshot dimensions are incorrect"

**Solution:**
- Verify source image quality (higher resolution is better)
- Use the resize script which handles exact dimensions
- Check output files with Preview or `sips -g pixelWidth -g pixelHeight file.png`

#### Issue: "Screenshots appear stretched or distorted"

**Solution:**
- Source images should have similar aspect ratio to target
- Use "fit" mode (default) which adds padding instead of stretching
- For iPhone: Use portrait orientation (tall)
- For iPad: Can use portrait or landscape
- For macOS: Use landscape orientation (wide)

#### Issue: "Script can't find screenshots"

**Solution:**
- Check naming convention: must include `iphone`, `ipad`, or `macos` in filename
- Ensure files are in source directory
- Use case-insensitive names: `iPhone`, `iphone`, `IPHONE` all work
- Check file extensions: `.png` or `.jpg` only

#### Issue: "ImageMagick not found"

**Solution:**
```bash
# Install via Homebrew
brew install imagemagick

# Verify installation
magick --version

# Or use sips-only mode (script will automatically fall back)
```

#### Issue: "Output quality is poor"

**Solution:**
- Start with highest quality source images
- Use PNG format (lossless)
- Install ImageMagick for better resizing algorithm
- Capture screenshots at 2x or 3x resolution
- Use actual devices/simulators at correct resolution

### Validation

#### Check Screenshot Dimensions

```bash
# Single file
sips -g pixelWidth -g pixelHeight screenshot.png

# All files in directory
for file in screenshots/appstore/iPhone/6.9-inch/*.png; do
  echo "File: $file"
  sips -g pixelWidth -g pixelHeight "$file" | grep "pixel"
done
```

#### Check File Sizes

```bash
# List file sizes
ls -lh screenshots/appstore/iPhone/6.9-inch/

# Find large files (>5MB)
find screenshots/appstore -type f -size +5M
```

**Tip**: Keep screenshots under 5MB each for faster uploads.

## Tools

### Included Script

**`scripts/resize-screenshots.sh`**
- Automatic batch processing
- Creates all required sizes
- Organized output structure
- Progress reporting
- Quality optimization

**Usage:**
```bash
./scripts/resize-screenshots.sh [source_dir] [output_dir]
```

### Third-Party Tools

#### Screenshot Apps

1. **Shottr** (Free)
   - Website: https://shottr.cc
   - Features: Annotations, blur, pixel-perfect selection
   - Great for: macOS screenshots with markup

2. **CleanShot X** (Paid)
   - Website: https://cleanshot.com
   - Features: Scrolling capture, annotations, cloud upload
   - Great for: Professional screenshots with overlays

3. **Xnapper** (Paid)
   - Website: https://xnapper.com
   - Features: Beautiful backgrounds, device frames
   - Great for: Marketing screenshots with style

#### Design Tools

1. **Figma** (Free/Paid)
   - Create mockups with device frames
   - Export at exact dimensions
   - Team collaboration

2. **Sketch** (Paid)
   - Professional design tool
   - Artboards at exact sizes
   - Plugin ecosystem

3. **Pixelmator Pro** (Paid)
   - Native macOS app
   - Advanced editing
   - Batch processing

### Command-Line Tools

#### ImageMagick (Recommended)

```bash
# Install
brew install imagemagick

# Basic resize
magick input.png -resize 1320x2868 output.png

# Resize with padding
magick input.png -resize 1320x2868 -gravity center \
  -background white -extent 1320x2868 output.png

# Batch convert to PNG
magick mogrify -format png *.jpg
```

#### sips (Built-in)

```bash
# Get image info
sips -g all image.png

# Resize
sips -Z 2868 image.png

# Batch resize
sips -Z 2868 *.png

# Convert format
sips -s format png image.jpg --out image.png
```

#### optipng (Optimization)

```bash
# Install
brew install optipng

# Optimize PNG file size
optipng -o7 screenshot.png

# Batch optimize
optipng -o7 screenshots/appstore/**/*.png
```

## Appendix

### Screenshot Checklist

Before uploading to App Store Connect:

- [ ] Captured screenshots on correct devices/simulators
- [ ] Named files with correct conventions
- [ ] Ran resize script successfully
- [ ] Verified dimensions of output files
- [ ] Checked image quality (no blur, distortion)
- [ ] Prepared 3-10 screenshots per device size
- [ ] Ordered screenshots by importance
- [ ] Removed any debug information
- [ ] Used actual app data (not placeholders)
- [ ] Tested light and dark mode variants
- [ ] Created localized versions (if applicable)
- [ ] Reviewed all screenshots in Preview
- [ ] File sizes under 5MB each
- [ ] All screenshots use PNG format

### Resources

**Apple Documentation:**
- [Screenshot Specifications](https://help.apple.com/app-store-connect/#/devd274dd925)
- [App Store Marketing Guidelines](https://developer.apple.com/app-store/marketing/guidelines/)
- [Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/)

**App Store Connect:**
- [App Store Connect](https://appstoreconnect.apple.com)
- [Support Articles](https://developer.apple.com/support/app-store-connect/)

**Related Documentation:**
- [Project README](../README.md)
- [Build Instructions](../makefile)
- [Icon Generation](./APP_ICON_SETUP.md)

### Quick Reference

**Minimum Required:**
- iPhone: 1 device size (recommend 6.9" or 6.7")
- iPad: 1 device size (recommend 12.9")
- macOS: 1 screenshot set

**Recommended:**
- iPhone: 6.9", 6.7", 6.1" (covers 95%+ of users)
- iPad: 12.9" and 11" (covers all iPad Pros)
- macOS: 2880×1800 (Retina display)

**File Format:**
- PNG (recommended)
- RGB color space
- No transparency
- Under 5MB per file

**Quantity:**
- Minimum: 3 screenshots
- Maximum: 10 screenshots
- Recommended: 5-6 screenshots

---

**Last Updated**: October 3, 2025  
**Version**: 1.0.0
