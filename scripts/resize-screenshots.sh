#!/bin/bash

#==============================================================================
# App Store Screenshot Resizer
# 
# Resizes screenshots to meet Apple App Store Connect requirements
# Supports iPhone, iPad, and macOS (Mac Catalyst) screenshots
#
# Usage: ./resize-screenshots.sh [source_dir] [output_dir]
#
# Requirements:
#   - ImageMagick (install: brew install imagemagick)
#   - sips (built-in on macOS)
#==============================================================================

set -e  # Exit on error

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Default directories
SOURCE_DIR="${1:-./screenshots/originals}"
OUTPUT_DIR="${2:-./screenshots/appstore}"

# Create output directory structure
IPHONE_DIR="$OUTPUT_DIR/iPhone"
IPAD_DIR="$OUTPUT_DIR/iPad"
MACOS_DIR="$OUTPUT_DIR/macOS"

#==============================================================================
# Apple App Store Screenshot Requirements (as of October 2025)
#==============================================================================

# iPhone 6.9" Display (iPhone 16 Pro Max, 15 Pro Max, 14 Pro Max)
IPHONE_69_WIDTH=1320
IPHONE_69_HEIGHT=2868

# iPhone 6.7" Display (iPhone 16 Plus, 15 Plus, 14 Plus)
IPHONE_67_WIDTH=1290
IPHONE_67_HEIGHT=2796

# iPhone 6.5" Display (iPhone 11 Pro Max, XS Max)
IPHONE_65_WIDTH=1242
IPHONE_65_HEIGHT=2688

# iPhone 6.1" Display (iPhone 16 Pro, 15 Pro, 14 Pro, 13, 12)
IPHONE_61_WIDTH=1179
IPHONE_61_HEIGHT=2556

# iPhone 5.5" Display (iPhone 8 Plus, 7 Plus, 6s Plus)
IPHONE_55_WIDTH=1242
IPHONE_55_HEIGHT=2208

# iPad Pro 12.9" (6th gen, 5th gen, 4th gen, 3rd gen)
IPAD_129_WIDTH=2048
IPAD_129_HEIGHT=2732

# iPad Pro 11" (all generations)
IPAD_11_WIDTH=1668
IPAD_11_HEIGHT=2388

# macOS (minimum 1280x800, recommended 2880x1800)
MACOS_WIDTH=2880
MACOS_HEIGHT=1800

#==============================================================================
# Functions
#==============================================================================

print_header() {
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}  $1${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

check_dependencies() {
    print_header "Checking Dependencies"
    
    local missing_deps=0
    
    # Check for sips (built-in on macOS)
    if command -v sips &> /dev/null; then
        print_success "sips found (built-in macOS tool)"
    else
        print_error "sips not found (should be built-in on macOS)"
        missing_deps=$((missing_deps + 1))
    fi
    
    # Check for ImageMagick (optional but recommended)
    if command -v magick &> /dev/null || command -v convert &> /dev/null; then
        print_success "ImageMagick found"
        USE_IMAGEMAGICK=true
    else
        print_warning "ImageMagick not found (install with: brew install imagemagick)"
        print_info "Will use sips only (limited features)"
        USE_IMAGEMAGICK=false
    fi
    
    echo ""
    
    if [ $missing_deps -gt 0 ]; then
        print_error "Missing required dependencies. Please install them first."
        exit 1
    fi
}

create_directories() {
    print_header "Creating Output Directories"
    
    mkdir -p "$IPHONE_DIR/6.9-inch"
    mkdir -p "$IPHONE_DIR/6.7-inch"
    mkdir -p "$IPHONE_DIR/6.5-inch"
    mkdir -p "$IPHONE_DIR/6.1-inch"
    mkdir -p "$IPHONE_DIR/5.5-inch"
    mkdir -p "$IPAD_DIR/12.9-inch"
    mkdir -p "$IPAD_DIR/11-inch"
    mkdir -p "$MACOS_DIR"
    
    print_success "Created output directory structure"
    echo ""
}

get_image_dimensions() {
    local file="$1"
    sips -g pixelWidth -g pixelHeight "$file" | tail -2 | awk '{print $2}' | tr '\n' 'x' | sed 's/x$//'
}

resize_image() {
    local input="$1"
    local output="$2"
    local width="$3"
    local height="$4"
    local method="${5:-fit}"  # fit, fill, or exact
    
    # Get original dimensions
    local orig_dims=$(get_image_dimensions "$input")
    local orig_width=$(echo "$orig_dims" | cut -d'x' -f1)
    local orig_height=$(echo "$orig_dims" | cut -d'x' -f2)
    
    # Calculate aspect ratios
    local target_aspect=$(echo "scale=4; $width / $height" | bc)
    local orig_aspect=$(echo "scale=4; $orig_width / $orig_height" | bc)
    
    if [ "$USE_IMAGEMAGICK" = true ]; then
        # Use ImageMagick for better quality
        if [ "$method" = "fill" ]; then
            # Fill mode: crop to fit exact dimensions
            magick "$input" -resize "${width}x${height}^" -gravity center -extent "${width}x${height}" "$output"
        elif [ "$method" = "exact" ]; then
            # Exact mode: stretch to dimensions (may distort)
            magick "$input" -resize "${width}x${height}!" "$output"
        else
            # Fit mode: resize to fit within dimensions (default)
            magick "$input" -resize "${width}x${height}" -gravity center -background white -extent "${width}x${height}" "$output"
        fi
    else
        # Use sips (built-in, simpler)
        if [ "$method" = "fill" ] || [ "$method" = "exact" ]; then
            sips -z "$height" "$width" "$input" --out "$output" > /dev/null 2>&1
        else
            # Fit within dimensions
            sips -Z "$(echo "$width < $height" | bc -l | grep -q 1 && echo "$width" || echo "$height")" "$input" --out "$output" > /dev/null 2>&1
            # Add padding if needed
            sips -z "$height" "$width" --padToHeightWidth "$height" "$width" --padColor FFFFFF "$output" > /dev/null 2>&1
        fi
    fi
    
    if [ $? -eq 0 ]; then
        return 0
    else
        return 1
    fi
}

process_iphone_screenshots() {
    print_header "Processing iPhone Screenshots"
    
    local iphone_files=($(find "$SOURCE_DIR" -type f \( -name "*iphone*.png" -o -name "*iphone*.jpg" -o -name "*iPhone*.png" -o -name "*iPhone*.jpg" \) 2>/dev/null || echo ""))
    
    if [ ${#iphone_files[@]} -eq 0 ]; then
        print_warning "No iPhone screenshots found in $SOURCE_DIR"
        echo ""
        return
    fi
    
    print_info "Found ${#iphone_files[@]} iPhone screenshot(s)"
    echo ""
    
    for file in "${iphone_files[@]}"; do
        local filename=$(basename "$file")
        local basename="${filename%.*}"
        
        print_info "Processing: $filename"
        
        # iPhone 6.9" (Priority: iPhone 16 Pro Max)
        if resize_image "$file" "$IPHONE_DIR/6.9-inch/${basename}_6.9inch.png" "$IPHONE_69_WIDTH" "$IPHONE_69_HEIGHT" "fit"; then
            print_success "  → 6.9\" (1320x2868) - iPhone 16 Pro Max"
        else
            print_error "  → Failed to create 6.9\" version"
        fi
        
        # iPhone 6.7"
        if resize_image "$file" "$IPHONE_DIR/6.7-inch/${basename}_6.7inch.png" "$IPHONE_67_WIDTH" "$IPHONE_67_HEIGHT" "fit"; then
            print_success "  → 6.7\" (1290x2796) - iPhone 16 Plus"
        else
            print_error "  → Failed to create 6.7\" version"
        fi
        
        # iPhone 6.5"
        if resize_image "$file" "$IPHONE_DIR/6.5-inch/${basename}_6.5inch.png" "$IPHONE_65_WIDTH" "$IPHONE_65_HEIGHT" "fit"; then
            print_success "  → 6.5\" (1242x2688) - iPhone 11 Pro Max"
        else
            print_error "  → Failed to create 6.5\" version"
        fi
        
        # iPhone 6.1"
        if resize_image "$file" "$IPHONE_DIR/6.1-inch/${basename}_6.1inch.png" "$IPHONE_61_WIDTH" "$IPHONE_61_HEIGHT" "fit"; then
            print_success "  → 6.1\" (1179x2556) - iPhone 16 Pro"
        else
            print_error "  → Failed to create 6.1\" version"
        fi
        
        # iPhone 5.5" (Legacy)
        if resize_image "$file" "$IPHONE_DIR/5.5-inch/${basename}_5.5inch.png" "$IPHONE_55_WIDTH" "$IPHONE_55_HEIGHT" "fit"; then
            print_success "  → 5.5\" (1242x2208) - iPhone 8 Plus (Legacy)"
        else
            print_error "  → Failed to create 5.5\" version"
        fi
        
        echo ""
    done
}

process_ipad_screenshots() {
    print_header "Processing iPad Screenshots"
    
    local ipad_files=($(find "$SOURCE_DIR" -type f \( -name "*ipad*.png" -o -name "*ipad*.jpg" -o -name "*iPad*.png" -o -name "*iPad*.jpg" \) 2>/dev/null || echo ""))
    
    if [ ${#ipad_files[@]} -eq 0 ]; then
        print_warning "No iPad screenshots found in $SOURCE_DIR"
        echo ""
        return
    fi
    
    print_info "Found ${#ipad_files[@]} iPad screenshot(s)"
    echo ""
    
    for file in "${ipad_files[@]}"; do
        local filename=$(basename "$file")
        local basename="${filename%.*}"
        
        print_info "Processing: $filename"
        
        # iPad Pro 12.9"
        if resize_image "$file" "$IPAD_DIR/12.9-inch/${basename}_12.9inch.png" "$IPAD_129_WIDTH" "$IPAD_129_HEIGHT" "fit"; then
            print_success "  → 12.9\" (2048x2732) - iPad Pro 12.9\""
        else
            print_error "  → Failed to create 12.9\" version"
        fi
        
        # iPad Pro 11"
        if resize_image "$file" "$IPAD_DIR/11-inch/${basename}_11inch.png" "$IPAD_11_WIDTH" "$IPAD_11_HEIGHT" "fit"; then
            print_success "  → 11\" (1668x2388) - iPad Pro 11\""
        else
            print_error "  → Failed to create 11\" version"
        fi
        
        echo ""
    done
}

process_macos_screenshots() {
    print_header "Processing macOS Screenshots"
    
    local macos_files=($(find "$SOURCE_DIR" -type f \( -name "*macos*.png" -o -name "*macos*.jpg" -o -name "*macOS*.png" -o -name "*macOS*.jpg" -o -name "*mac*.png" -o -name "*mac*.jpg" \) 2>/dev/null || echo ""))
    
    if [ ${#macos_files[@]} -eq 0 ]; then
        print_warning "No macOS screenshots found in $SOURCE_DIR"
        echo ""
        return
    fi
    
    print_info "Found ${#macos_files[@]} macOS screenshot(s)"
    echo ""
    
    for file in "${macos_files[@]}"; do
        local filename=$(basename "$file")
        local basename="${filename%.*}"
        
        print_info "Processing: $filename"
        
        # macOS (2880x1800 recommended for Retina displays)
        if resize_image "$file" "$MACOS_DIR/${basename}_macos.png" "$MACOS_WIDTH" "$MACOS_HEIGHT" "fit"; then
            print_success "  → macOS (2880x1800) - Retina Display"
        else
            print_error "  → Failed to create macOS version"
        fi
        
        echo ""
    done
}

generate_summary() {
    print_header "Summary"
    
    echo "Output directories:"
    echo ""
    echo "📱 iPhone Screenshots:"
    echo "   • 6.9\" (1320x2868): $IPHONE_DIR/6.9-inch/"
    echo "   • 6.7\" (1290x2796): $IPHONE_DIR/6.7-inch/"
    echo "   • 6.5\" (1242x2688): $IPHONE_DIR/6.5-inch/"
    echo "   • 6.1\" (1179x2556): $IPHONE_DIR/6.1-inch/"
    echo "   • 5.5\" (1242x2208): $IPHONE_DIR/5.5-inch/"
    echo ""
    echo "📱 iPad Screenshots:"
    echo "   • 12.9\" (2048x2732): $IPAD_DIR/12.9-inch/"
    echo "   • 11\" (1668x2388): $IPAD_DIR/11-inch/"
    echo ""
    echo "💻 macOS Screenshots:"
    echo "   • Retina (2880x1800): $MACOS_DIR/"
    echo ""
    
    print_success "All screenshots processed successfully!"
    echo ""
    print_info "Next Steps:"
    echo "  1. Review resized screenshots for quality"
    echo "  2. Upload to App Store Connect"
    echo "  3. Ensure you have at least 3 screenshots per device size"
    echo "  4. Maximum 10 screenshots per device size"
    echo ""
}

show_usage() {
    cat << EOF
${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}
  App Store Screenshot Resizer
${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}

${GREEN}USAGE:${NC}
  $0 [source_dir] [output_dir]

${GREEN}ARGUMENTS:${NC}
  source_dir    Source directory containing original screenshots
                Default: ./screenshots/originals
                
  output_dir    Output directory for resized screenshots
                Default: ./screenshots/appstore

${GREEN}NAMING CONVENTIONS:${NC}
  Place screenshots in source directory with these naming patterns:
  
  ${YELLOW}iPhone:${NC}  *iphone*.png or *iPhone*.png
  ${YELLOW}iPad:${NC}    *ipad*.png or *iPad*.png
  ${YELLOW}macOS:${NC}   *macos*.png, *macOS*.png, or *mac*.png

${GREEN}EXAMPLES:${NC}
  # Use default directories
  $0
  
  # Specify custom directories
  $0 ~/Desktop/screenshots ./output
  
  # Process specific platform
  mkdir -p ./screenshots/originals
  cp ~/Desktop/iphone_screenshot1.png ./screenshots/originals/
  $0

${GREEN}REQUIREMENTS:${NC}
  • sips (built-in on macOS)
  • ImageMagick (optional, for better quality)
    Install: brew install imagemagick

${GREEN}OUTPUT:${NC}
  Screenshots will be created in separate directories:
  • iPhone: 5 different sizes (6.9\", 6.7\", 6.5\", 6.1\", 5.5\")
  • iPad: 2 different sizes (12.9\", 11\")
  • macOS: 1 size (2880x1800)

${GREEN}APP STORE REQUIREMENTS:${NC}
  • Minimum 3 screenshots, maximum 10 per device size
  • At least one device size required per platform
  • PNG or JPEG format (PNG recommended)
  • RGB color space
  • No transparency in screenshots

EOF
}

#==============================================================================
# Main Script
#==============================================================================

main() {
    # Show usage if help flag is passed
    if [[ "$1" == "-h" || "$1" == "--help" ]]; then
        show_usage
        exit 0
    fi
    
    print_header "App Store Screenshot Resizer"
    echo ""
    echo "Source Directory: $SOURCE_DIR"
    echo "Output Directory: $OUTPUT_DIR"
    echo ""
    
    # Check if source directory exists
    if [ ! -d "$SOURCE_DIR" ]; then
        print_error "Source directory does not exist: $SOURCE_DIR"
        echo ""
        print_info "Creating source directory..."
        mkdir -p "$SOURCE_DIR"
        print_success "Created: $SOURCE_DIR"
        echo ""
        print_warning "Please add screenshots to $SOURCE_DIR and run again"
        echo ""
        show_usage
        exit 1
    fi
    
    # Check dependencies
    check_dependencies
    
    # Create output directories
    create_directories
    
    # Process screenshots by platform
    process_iphone_screenshots
    process_ipad_screenshots
    process_macos_screenshots
    
    # Show summary
    generate_summary
}

# Run main function
main "$@"
