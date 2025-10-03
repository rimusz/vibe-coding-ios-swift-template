# App Icon Setup Guide

This guide explains how to add app icons to your iOS, iPadOS, and macOS (Catalyst) project.

## 📱 Quick Setup

### Step 1: Prepare Your Master Icon
- Create or obtain a **1024×1024 pixel** PNG image of your app icon
- Ensure it's high quality and follows [Apple's App Icon Guidelines](https://developer.apple.com/design/human-interface-guidelines/app-icons)
- Name it something clear like `master-icon.png` or `app-icon-1024.png`

### Step 2: Add the Master Icon
Copy your 1024×1024 icon to the AppIcon folder:

```bash
# Navigate to your project
cd /path/to/YourProject

# Copy your master icon (replace with your actual icon path)
cp /path/to/your/icon.png Sources/Assets.xcassets/AppIcon.appiconset/master-icon.png
```

### Step 3: Generate All Required Sizes
Run the automatic icon generation script:

```bash
./scripts/generate-icons.sh
```

This script will:
- ✅ Find your 1024×1024 master icon
- ✅ Generate all required iOS, iPadOS, and macOS icon sizes
- ✅ Create properly named files for Xcode (28 icon files total)
- ✅ Work with the AppIcon.appiconset configured for all platforms

## 📋 Generated Icon Sizes

The script creates these icon files:

### iPhone Icons
- `icon-20@2x.png` (40×40) - Settings, Notification
- `icon-20@3x.png` (60×60) - Settings, Notification  
- `icon-29@2x.png` (58×58) - Settings, Spotlight
- `icon-29@3x.png` (87×87) - Settings, Spotlight
- `icon-40@2x.png` (80×80) - Spotlight
- `icon-40@3x.png` (120×120) - Spotlight
- `icon-60@2x.png` (120×120) - App Icon
- `icon-60@3x.png` (180×180) - App Icon

### iPad Icons
- `icon-20.png` (20×20) - Settings, Notification
- `icon-20@2x-ipad.png` (40×40) - Settings, Notification
- `icon-29.png` (29×29) - Settings
- `icon-29@2x-ipad.png` (58×58) - Settings
- `icon-40.png` (40×40) - Spotlight
- `icon-40@2x-ipad.png` (80×80) - Spotlight
- `icon-76.png` (76×76) - App Icon
- `icon-76@2x.png` (152×152) - App Icon
- `icon-83.5@2x.png` (167×167) - App Icon (iPad Pro)

### Mac Catalyst Icons
- `icon-16-mac.png` (16×16) - Finder, Dock (small)
- `icon-16@2x-mac.png` (32×32) - Finder, Dock (small) @2x
- `icon-32-mac.png` (32×32) - Finder, Dock
- `icon-32@2x-mac.png` (64×64) - Finder, Dock @2x
- `icon-128-mac.png` (128×128) - Finder, Dock (large)
- `icon-128@2x-mac.png` (256×256) - Finder, Dock (large) @2x
- `icon-256-mac.png` (256×256) - Finder icons
- `icon-256@2x-mac.png` (512×512) - Finder icons @2x
- `icon-512-mac.png` (512×512) - App Store, Finder
- `icon-512@2x-mac.png` (1024×1024) - App Store, Finder @2x

### App Store
- `icon-1024.png` (1024×1024) - App Store (iOS Marketing)

## 🔧 Troubleshooting

### Icons Not Showing in Xcode?
1. **Clean Build Folder**: `Cmd+Shift+K` in Xcode
2. **Restart Xcode**: Close and reopen completely
3. **Regenerate Project**: Run `make setup`
4. **Check File Permissions**: Ensure all PNG files are readable

### Script Errors?
- **"No master icon found"**: Make sure your 1024×1024 icon is in the AppIcon.appiconset folder
- **"Permission denied"**: Run `chmod +x scripts/generate-icons.sh`
- **"sips command not found"**: This should be available on all macOS systems

### Manual Verification
Check that icons were generated correctly:

```bash
# List all generated icons
ls -la Sources/Assets.xcassets/AppIcon.appiconset/*.png

# Check dimensions of a specific icon
sips -g pixelWidth -g pixelHeight Sources/Assets.xcassets/AppIcon.appiconset/icon-60@3x.png
```

## 🎨 Design Guidelines

### Apple's Requirements
- **Format**: PNG (no transparency for app icons)
- **Color Space**: sRGB or P3
- **Avoid**: Text, screenshots, or complex details that don't scale well
- **Style**: Consistent with iOS design language

### Best Practices
- Use a simple, recognizable design
- Ensure it looks good at small sizes (20×20)
- Test on both light and dark backgrounds
- Consider the rounded corners iOS applies automatically

## 📁 File Structure

After running the script, your AppIcon.appiconset should contain:

```
Sources/Assets.xcassets/AppIcon.appiconset/
├── Contents.json                # Xcode metadata
│
├── iPhone Icons (8 files)
├── icon-20@2x.png              # 40×40
├── icon-20@3x.png              # 60×60
├── icon-29@2x.png              # 58×58
├── icon-29@3x.png              # 87×87
├── icon-40@2x.png              # 80×80
├── icon-40@3x.png              # 120×120
├── icon-60@2x.png              # 120×120
├── icon-60@3x.png              # 180×180
│
├── iPad Icons (9 files)
├── icon-20.png                 # 20×20
├── icon-20@2x-ipad.png         # 40×40
├── icon-29.png                 # 29×29
├── icon-29@2x-ipad.png         # 58×58
├── icon-40.png                 # 40×40
├── icon-40@2x-ipad.png         # 80×80
├── icon-76.png                 # 76×76
├── icon-76@2x.png              # 152×152
├── icon-83.5@2x.png            # 167×167
│
├── Mac Catalyst Icons (10 files)
├── icon-16-mac.png             # 16×16
├── icon-16@2x-mac.png          # 32×32
├── icon-32-mac.png             # 32×32
├── icon-32@2x-mac.png          # 64×64
├── icon-128-mac.png            # 128×128
├── icon-128@2x-mac.png         # 256×256
├── icon-256-mac.png            # 256×256
├── icon-256@2x-mac.png         # 512×512
├── icon-512-mac.png            # 512×512
├── icon-512@2x-mac.png         # 1024×1024
│
└── App Store Icon (1 file)
    └── icon-1024.png           # 1024×1024
```

## 🚀 Next Steps

1. **Build Your App**: 
   - iOS: `make build` or `make run`
   - macOS: `make macos-build` or `make macos-run`
2. **Test on Device**: Icons should appear correctly on home screen (iOS/iPadOS) or Dock (macOS)
3. **Verify All Platforms**: 
   - iPhone simulator: Check home screen and Settings
   - iPad simulator: Check home screen and multitasking
   - Mac Catalyst: Check Dock, Finder, and About window
4. **Archive for Release**: `make archive` - includes all icon sizes for all platforms
5. **Submit to App Store**: Icons will be validated during submission

## 💡 Tips

- Keep your master icon file backed up
- Update icons by replacing the master and re-running the script
- Test icons on actual devices to see how they look
- Consider creating variants for different seasons/versions
- **Mac Catalyst**: Icons appear in Dock, Finder, About window, and menu bar
- **High Resolution**: macOS Retina displays use @2x versions automatically
- **Consistency**: Use same design across all platforms for brand recognition

## 📊 Platform Coverage

After running the script, you'll have complete icon coverage:

| Platform | Icon Sizes | Total Files | Primary Uses |
|----------|-----------|-------------|--------------|
| iPhone | 20pt-60pt (@2x, @3x) | 8 files | Home screen, Settings, Spotlight |
| iPad | 20pt-83.5pt (@1x, @2x) | 9 files | Home screen, Settings, Multitasking |
| macOS | 16pt-512pt (@1x, @2x) | 10 files | Dock, Finder, About window |
| App Store | 1024×1024 | 1 file | App Store listing |

**Total**: 28 icon files generated from one master icon

---

For more help with the build system, run `make help` in the project root.
