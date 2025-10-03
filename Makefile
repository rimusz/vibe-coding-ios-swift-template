# iOS/Mac App Makefile
# Variables
APP_NAME = MySwiftApp # Replace with your app name
APP_VERSION = 1.0.0
SCHEME = MySwiftApp # Replace with your Xcode scheme name
PROJECT = MySwiftApp.xcodeproj # Replace with your Xcode project file
BUNDLE_ID = # Replace with your app's bundle identifier
DEPLOYMENT_TARGET = 18.0 # Minimum iOS version supported
MIN_DEVICE = iPhone 15 Pro / iPad mini A17 Pro
TEAM_ID = # Replace with your Apple Developer Team ID
APP_STORE_CONNECT_URL = https://appstoreconnect.apple.com/ # postfix it with your app ID for direct link

# Physical Device Configuration (use DEVICE variable to choose: make dev-run DEVICE=ipad)
# Check available devices with: '$ make devices' and update IDs as needed
# iPhone
IPHONE_DEVICE_NAME = # Replace with your device name
IPHONE_DEVICE_ID = # Replace with your device UDID
# iPad
IPAD_DEVICE_NAME = # Replace with your device name
IPAD_DEVICE_ID = # Replace with your device UDID

# Default to iPhone
DEVICE ?= iphone
DEVICE_NAME = $(if $(filter ipad,$(DEVICE)),$(IPAD_DEVICE_NAME),$(IPHONE_DEVICE_NAME))
DEVICE_ID = $(if $(filter ipad,$(DEVICE)),$(IPAD_DEVICE_ID),$(IPHONE_DEVICE_ID))
DEVICE_DEST = platform=iOS,id=$(DEVICE_ID)

# Simulator IDs (use SIM variable to choose: make build SIM=iphone17 or SIM=ipad)
# Check available simulators with: '$ make simulators' and update IDs as needed
# iPhone Simulators
# iOS 18.0
IPHONE16_ID = # Replace with your iPhone 16 simulator ID
# iOS 26.0 
IPHONE16_PRO_ID = # Replace with your iPhone 16 Pro simulator ID
IPHONE16_PLUS_ID = # Replace with your iPhone 16 Plus simulator ID
IPHONE17_ID = # Replace with your iPhone 17 simulator ID
IPHONE17_PRO_ID = # Replace with your iPhone 17 Pro simulator ID
IPHONE17_PRO_MAX_ID = # Replace with your iPhone 17 Pro Max simulator ID

# iPad Simulators
# iPad mini (A17 Pro) with iOS 26.0
IPAD_MINI_A17_PRO_ID = # Replace with your iPad mini (A17 Pro) simulator ID

# Default simulator
SIM ?= iphone17pro
SIMULATOR_ID = $(if $(filter iphone16,$(SIM)),$(IPHONE16_ID),$(if $(filter iphone16pro,$(SIM)),$(IPHONE16_PRO_ID),$(if $(filter iphone16plus,$(SIM)),$(IPHONE16_PLUS_ID),$(if $(filter iphone17,$(SIM)),$(IPHONE17_ID),$(if $(filter iphone17pro,$(SIM)),$(IPHONE17_PRO_ID),$(if $(filter iphone17promax,$(SIM)),$(IPHONE17_PRO_MAX_ID),$(if $(filter ipad,$(SIM)),$(IPAD_MINI_A17_PRO_ID),$(IPHONE16_ID))))))))

SIMULATOR_DEST = platform=iOS Simulator,id=$(SIMULATOR_ID)

# Build number management - read from file, create if doesn't exist
define get_build_number
$(shell if [ -f build/BUILD_NUMBER ]; then cat build/BUILD_NUMBER; else mkdir -p build && echo "1" > build/BUILD_NUMBER && echo "1"; fi)
endef

BUILD_NUMBER = $(call get_build_number)

# Default target
.PHONY: help
help:
	@echo "MySwiftApp iOS App Build System"
	@echo "====================================="
	@echo ""
	@echo "📋 Project Setup:"
	@echo "  setup           - Generate Xcode project from project.yml"
	@echo "  set-version [VERSION=x.x.x] - Update app version (uses from makefile if not specified)"
	@echo "  clean           - Clean build artifacts"
	@echo "  info            - Show project information"
	@echo ""
	@echo "🧪 Testing:"
	@echo "  test                - Run tests on SIM"
	@echo "  test-verbose        - Run tests on SIM with detailed output"
	@echo "  test-coverage       - Run tests on SIM with code coverage report"
	@echo "  test-device         - Run tests on physical device
	@echo "  test-macos          - Run tests on macOS (Mac Catalyst)"
	@echo "  test-clean          - Clean test artifacts and derived data"
	@echo ""
	@echo "📱 Simulator Commands:"
	@echo "  simulators      - List available simulators"
	@echo "  build           - Build for iOS Simulator"
	@echo "  install         - Install app on simulator"
	@echo "  launch          - Launch app on simulator"
	@echo "  run             - Build, start iOS Simulator, install and run app"
	@echo "  run-hot         - Start InjectionIII for 🔥 Hot Reloading, build and run app"
	@echo ""
	@echo "🎯 Simulator Options (use SIM=simulator_name):"
	@echo "  iPhone:"
	@echo "    iphone16        - iPhone 16 (default with iOS $$(SIMULATOR_IOS_VERSION))"
	@echo "    iphone16pro     - iPhone 16 Pro"
	@echo "    iphone16plus    - iPhone 16 Plus"
	@echo "    iphone17        - iPhone 17"
	@echo "    iphone17pro     - iPhone 17 Pro"
	@echo "    iphone17promax  - iPhone 17 Pro Max"
	@echo "  iPad:"
	@echo "    ipad            - iPad mini (A17 Pro)"
	@echo ""
	@echo "💡 Simulator Examples:"
	@echo "  make test SIM=iphone17pro   - Run tests on iPhone 17 Pro simulator"
	@echo "  make test SIM=ipad          - Run tests on iPad mini A17 Pro simulator"
	@echo "  make build SIM=iphone17pro  - Build for iPhone 17 Pro simulator"
	@echo "  make run SIM=iphone17pro    - Run on iPhone 17 Pro simulator"
	@echo "  make run SIM=ipad           - Run on iPad mini A17 Pro simulator"
	@echo ""
	@echo "📱 Physical Device Commands (iPhone is default, set DEVICE=ipad for the iPad mini):"
	@echo "  devices              - List available physical devices"
	@echo "  dev-status           - Check configured device status"
	@echo "  dev-build            - Build for physical device"
	@echo "  dev-install          - Install app on physical device"
	@echo "  dev-launch           - Launch app on physical device"
	@echo "  dev-run              - Build, install and launch on iPhone (default)"
	@echo "  dev-run DEVICE=ipad  - Build and run on iPad"
	@echo ""
	@echo "� Device Requirements:"
	@echo "  - Minimum Required: $(MIN_DEVICE)"
	@echo "  - Minimum iOS Version: $(DEPLOYMENT_TARGET)+"
	@echo "  - USB: Connect with Apple cable and trust computer"
	@echo "  - WiFi: Enable Settings → Developer → Connect via Network"
	@echo ""
	@echo "🍎 macOS Commands:"
	@echo "  macos-build     - Build for macOS"
	@echo "  macos-run       - Build and run on macOS"
	@echo "  macos-clean     - Clean macOS build artifacts"
	@echo ""
	@echo "🚀 Release & TestFlight Deployment:"
	@echo "  archive                     - Archive for release (auto-increments build number) for TestFlight upload"
	@echo "  upload-testflight           - Upload existing archive to TestFlight"
	@echo "  create-tag [VERSION=x.x.x]  - Create and push git tag local/v$(APP_VERSION) (uses APP_VERSION if not specified)"
	@echo "  local-release               - Local release workflow (archive + tag + upload to TestFlight)"
	@echo "  xcode-cloud-release         - Xcode Cloud release workflow (tag + build + upload to TestFlight)"
	@echo ""
# Generate Xcode project
.PHONY: setup
setup:
	@echo "🔨 Generating Xcode project..."
	xcodegen generate

# Build for simulator
.PHONY: build
build: setup
	@echo "🔨 Building $(APP_NAME) v$(APP_VERSION) for iOS Simulator..."
	xcodebuild build \
		-project $(PROJECT) \
		-scheme $(SCHEME) \
		-destination '$(SIMULATOR_DEST)' \
		-configuration Debug \
		MARKETING_VERSION=$(APP_VERSION)

# Build and run in simulator
.PHONY: run
run: build boot-simulator install launch

# Install app on simulator
.PHONY: install
install:
	@echo "📱 Installing $(APP_NAME) on $(SIM) ($(SIMULATOR_ID)) simulator..."
	xcrun simctl install $(SIMULATOR_ID) $(shell find ~/Library/Developer/Xcode/DerivedData -path "*/Debug-iphonesimulator/$(APP_NAME).app" | head -1)

# Launch app on simulator
.PHONY: launch
launch:
	@echo "🚀 Launching $(APP_NAME)..."
	xcrun simctl launch $(SIMULATOR_ID) $(BUNDLE_ID)

# Clean test artifacts
.PHONY: test-clean
test-clean:
	@echo "🧹 Cleaning test artifacts..."
	rm -rf ./build/DerivedData
	rm -rf ~/Library/Developer/Xcode/DerivedData/$(APP_NAME)-*/

# Run unit tests (excludes StoreKit integration tests)
.PHONY: test
test: test-clean
	@echo "🧪 Running tests for $(APP_NAME) (excluding StoreKit integration tests)..."
	xcodebuild test \
		-project $(PROJECT) \
		-scheme $(SCHEME) \
		-destination '$(SIMULATOR_DEST)' \
		-configuration Debug \
		-skip-testing:MySwiftAppTests/StoreManagerIntegrationTests

# Run tests with detailed output
.PHONY: test-verbose
test-verbose: test-clean
	@echo "🧪 Running tests with verbose output for $(APP_NAME)..."
	xcodebuild test \
		-project $(PROJECT) \
		-scheme $(SCHEME) \
		-destination '$(SIMULATOR_DEST)' \
		-configuration Debug \
		-skip-testing:MySwiftAppTests/StoreManagerIntegrationTests \
		-verbose

# Run tests and generate code coverage report
.PHONY: test-coverage
test-coverage: test-clean
	@echo "🧪 Running tests with code coverage for $(APP_NAME)..."
	xcodebuild test \
		-project $(PROJECT) \
		-scheme $(SCHEME) \
		-destination '$(SIMULATOR_DEST)' \
		-configuration Debug \
		-enableCodeCoverage YES \
		-skip-testing:MySwiftAppTests/StoreManagerIntegrationTests \
		-derivedDataPath ./build/DerivedData

# Run tests on device
.PHONY: test-device
test-device: test-clean
	@echo "🧪 Running tests on device: $(DEVICE_NAME)..."
	xcodebuild test \
		-project $(PROJECT) \
		-scheme $(SCHEME) \
		-destination "platform=iOS,id=$(DEVICE_ID)" \
		-configuration Debug

# Run tests on macOS (Mac Catalyst)
.PHONY: test-macos
test-macos: test-clean
	@echo "🍎 Running tests on macOS (Mac Catalyst)..."
	xcodebuild test \
		-project $(PROJECT) \
		-scheme $(SCHEME) \
		-destination 'platform=macOS,variant=Mac Catalyst' \
		-configuration Debug \
		-skip-testing:MySwiftAppTests/StoreManagerIntegrationTests

# Build for physical device
.PHONY: setup dev-build
dev-build:
	@echo "🔨 Building $(APP_NAME) v$(APP_VERSION) for device: $(DEVICE_NAME) ($(DEVICE_ID))..."
	xcodebuild build \
		-project $(PROJECT) \
		-scheme $(SCHEME) \
		-destination "platform=iOS,id=$(DEVICE_ID)" \
		-configuration Release \
		CODE_SIGN_IDENTITY="iPhone Developer" \
		DEVELOPMENT_TEAM=$(TEAM_ID) \
		MARKETING_VERSION=$(APP_VERSION)

# Install app on physical device
.PHONY: dev-install
dev-install:
	@echo "📱 Installing $(APP_NAME) on device: $(DEVICE_NAME)..."
	@APP_PATH=$$(find ~/Library/Developer/Xcode/DerivedData -path "*/Build/Products/Release-iphoneos/$(APP_NAME).app" -not -path "*/ArchiveIntermediates/*" | head -1); \
	if [ -z "$$APP_PATH" ]; then \
		echo "❌ App not found. Run 'make dev-build' first."; \
		exit 1; \
	fi; \
	echo "Installing from: $$APP_PATH"; \
	xcrun devicectl device install app --device $(DEVICE_ID) "$$APP_PATH" || \
	(echo "⚠️  Trying fallback method with instruments..." && \
	 xcrun instruments -w $(DEVICE_ID) -t "Activity Monitor" -D /tmp &>/dev/null & sleep 2 && \
	 echo "Device connection established, please install manually through Xcode")

# Launch app on physical device
.PHONY: dev-launch
dev-launch:
	@echo "🚀 Launching $(APP_NAME) on device: $(DEVICE_NAME)..."
	@echo "⏳ Starting app..."
	@(xcrun devicectl device process launch --device $(DEVICE_ID) --terminate-existing $(BUNDLE_ID) > /tmp/launch.log 2>&1 & \
	 LAUNCH_PID=$$!; \
	 sleep 8; \
	 kill $$LAUNCH_PID 2>/dev/null || true; \
	 wait $$LAUNCH_PID 2>/dev/null || true; \
	 grep -q "Launched application" /tmp/launch.log && echo "✅ App launched successfully!" || echo "⚠️  Launch initiated (check device)")
	@echo "📱 Device: $(DEVICE_NAME)"
	@echo "💡 If app didn't appear, ensure Developer Mode is enabled on your device"

# Build, install and launch on physical device
.PHONY: dev-run
dev-run: dev-build dev-install dev-launch

# Build for macOS (using Mac Catalyst)
.PHONY: macos-build
macos-build: setup
	@echo "🍎 Building $(APP_NAME) for macOS (Mac Catalyst)..."
	xcodebuild build \
		-project $(PROJECT) \
		-scheme $(SCHEME) \
		-destination 'platform=macOS,variant=Mac Catalyst' \
		-configuration Debug
	@echo "✅ Build for macOS (Mac Catalyst) completed"

# Build and run on macOS (using Mac Catalyst)
.PHONY: macos-run
macos-run: macos-build
	@echo "🚀 Launching $(APP_NAME) on macOS (Mac Catalyst)..."
	@echo "🔍 Checking if $(APP_NAME) is already running..."
	@osascript -e 'quit app "$(APP_NAME)"' 2>/dev/null || true
	@APP_PATH=$$(find ~/Library/Developer/Xcode/DerivedData -path "*/Build/Products/Debug-maccatalyst/$(APP_NAME).app" -type d 2>/dev/null | head -n 1); \
	if [ -z "$$APP_PATH" ]; then \
		echo "❌ Error: Could not find $(APP_NAME).app for Mac Catalyst"; \
		echo ""; \
		echo "⚠️  This project needs Mac Catalyst enabled."; \
		echo "� To enable Mac Catalyst support:"; \
		echo "   1. Edit project.yml"; \
		echo "   2. Change 'SUPPORTS_MACCATALYST: false' to 'SUPPORTS_MACCATALYST: true'"; \
		echo "   3. Run 'make setup' to regenerate the project"; \
		echo "   4. Then try 'make macos-run' again"; \
		exit 1; \
	fi; \
	echo "📱 Found app at: $$APP_PATH"; \
	echo "🔄 Closing any existing instance and opening fresh..."; \
	open "$$APP_PATH"

# Clean macOS build artifacts
.PHONY: macos-clean
macos-clean:
	@echo "🧹 Cleaning macOS build artifacts..."
	rm -rf ~/Library/Developer/Xcode/DerivedData/$(APP_NAME)-*/
	@echo "✅ macOS build artifacts cleaned"

# Increment build number in build/BUILD_NUMBER file, project.yml, and Info.plist
.PHONY: increment-build
increment-build:
	@mkdir -p build; \
	if [ -f build/BUILD_NUMBER ]; then \
		CURRENT_BUILD=$$(cat build/BUILD_NUMBER); \
	else \
		CURRENT_BUILD=0; \
	fi; \
	NEW_BUILD=$$((CURRENT_BUILD + 1)); \
	echo "📝 Incrementing build number from $$CURRENT_BUILD to $$NEW_BUILD..."; \
	echo "📝 Updating build/BUILD_NUMBER file..."; \
	echo "$$NEW_BUILD" > build/BUILD_NUMBER; \
	echo "📝 Updating project.yml..."; \
	cp project.yml project.yml.backup; \
	awk '/CURRENT_PROJECT_VERSION:/ {print "  CURRENT_PROJECT_VERSION: \"'"$$NEW_BUILD"'\""} !/CURRENT_PROJECT_VERSION:/ {print}' project.yml.backup | \
	awk '/CFBundleVersion:/ {print "        CFBundleVersion: \"'"$$NEW_BUILD"'\""} !/CFBundleVersion:/ {print}' > project.yml; \
	rm project.yml.backup; \
	echo "📝 Info.plist will be updated automatically by xcodegen..."; \
	echo "✅ Build number updated to $$NEW_BUILD in build/BUILD_NUMBER and project.yml"; \
	echo "🔄 Regenerating Xcode project with new build number..."; \
	xcodegen generate; \
	echo "✅ Xcode project regenerated with build $$NEW_BUILD"

# Set build number manually in build/BUILD_NUMBER file, project.yml, and Info.plist
.PHONY: set-build
set-build:
	@if [ -z "$(BUILD)" ]; then \
		echo "❌ Error: BUILD parameter is required. Usage: make set-build BUILD=123"; \
		exit 1; \
	fi; \
	echo "📝 Setting build number to $(BUILD)..."; \
	echo "📝 Updating build/BUILD_NUMBER file..."; \
	mkdir -p build; \
	echo "$(BUILD)" > build/BUILD_NUMBER; \
	echo "📝 Updating project.yml..."; \
	cp project.yml project.yml.backup; \
	awk '/CURRENT_PROJECT_VERSION:/ {print "  CURRENT_PROJECT_VERSION: \"$(BUILD)\""} !/CURRENT_PROJECT_VERSION:/ {print}' project.yml.backup | \
	awk '/CFBundleVersion:/ {print "        CFBundleVersion: \"$(BUILD)\""} !/CFBundleVersion:/ {print}' > project.yml; \
	rm project.yml.backup; \
	echo "📝 Info.plist will be updated automatically by xcodegen..."; \
	echo "✅ Build number set to $(BUILD) in build/BUILD_NUMBER and project.yml"; \
	echo "🔄 Regenerating Xcode project with build number $(BUILD)..."; \
	xcodegen generate; \
	echo "✅ Xcode project regenerated with build $(BUILD)"

# Update app version in makefile, Info.plist, and project.yml
.PHONY: set-version
set-version:
	@if [ -z "$(VERSION)" ]; then \
		VERSION=$(APP_VERSION); \
		echo "📋 No version specified, using current APP_VERSION: $$VERSION"; \
	else \
		VERSION=$(VERSION); \
	fi; \
	echo "📝 Updating app version from $(APP_VERSION) to $$VERSION..."; \
	echo "📝 Updating makefile..."; \
	cp makefile makefile.backup; \
	awk '/^APP_VERSION = / {print "APP_VERSION = '"$$VERSION"'"} !/^APP_VERSION = / {print}' makefile.backup > makefile; \
	rm makefile.backup; \
	echo "📝 Updating project.yml..."; \
	cp project.yml project.yml.backup; \
	awk '/MARKETING_VERSION:/ {print "  MARKETING_VERSION: \"'"$$VERSION"'\""} !/MARKETING_VERSION:/ {print}' project.yml.backup | \
	awk '/CFBundleShortVersionString:/ {print "        CFBundleShortVersionString: \"'"$$VERSION"'\""} !/CFBundleShortVersionString:/ {print}' > project.yml; \
	rm project.yml.backup; \
	echo "📝 Resetting build number..."; \
	rm -f build/BUILD_NUMBER; \
	echo "✅ Version updated to $$VERSION in makefile and project.yml (both MARKETING_VERSION and CFBundleShortVersionString updated)"; \
	echo "✅ Build number reset - next build will start from 1"; \
	echo "🔄 Regenerating Xcode project with new version..."; \
	xcodegen generate; \
	echo "✅ Xcode project regenerated with version $$VERSION"; \

# Clean build artifacts
.PHONY: clean
clean:
	@echo "🧹 Cleaning build artifacts..."
	xcodebuild clean -project $(PROJECT) -scheme $(SCHEME)
	rm -rf build/
	mkdir -p build/
	rm -rf ~/Library/Developer/Xcode/DerivedData/$(APP_NAME)-*

# Boot simulator if not running
.PHONY: boot-simulator
boot-simulator:
	@echo "📱 Opening iOS Simulator: $(SIM) ($(SIMULATOR_ID))..."
	@echo "Booting simulator if not already running..."
	@xcrun simctl boot $(SIMULATOR_ID) 2>/dev/null || true
	@echo "Opening Simulator app..."
	@open -a Simulator
	@echo "✅ Simulator opened. Device: $(SIM)"

# Shutdown simulator
.PHONY: shutdown-simulator
shutdown-simulator:
	@echo "🛑 Shutting down iOS Simulator $(SIMULATOR_ID)..."
	xcrun simctl shutdown $(SIMULATOR_ID)

# List available physical devices
.PHONY: devices
devices:
	@echo "📱 Available Physical Devices:"
	@echo "Current configured device: $(DEVICE_NAME) ($(DEVICE_ID))"
	@echo ""
	@echo "🔌 Connected Physical Devices:"
	@echo "Using xcrun devicectl list devices:"
	@xcrun devicectl list devices 2>/dev/null | grep -E "iPhone|iPad" || echo "  No devices found with devicectl"
	@echo ""
	@echo "📋 All iOS Build Destinations:"
	@xcodebuild -project $(PROJECT) -scheme $(SCHEME) -showdestinations 2>/dev/null | grep -E "platform:iOS" | grep -v "Simulator" | head -5 || echo "  No physical devices in build destinations"
	@echo ""
	@echo "💡 Note: Make sure your device is:"
	@echo "   - Connected via USB or WiFi"
	@echo "   - Trusted (check device for trust dialog)"
	@echo "   - Added to your Apple Developer account"
	@echo "   - Has a valid development certificate"

# Check configured device status
.PHONY: dev-status
dev-status:
	@echo "🔍 Checking status of configured device: $(DEVICE_NAME)"
	@echo "  Device ID: $(DEVICE_ID)"
	@echo ""
	@echo "Checking if device is available for building..."
	@xcodebuild -project $(PROJECT) -scheme $(SCHEME) -showdestinations 2>/dev/null | grep -q "$(DEVICE_ID)" && \
		echo "✅ Device is available for building" || \
		echo "❌ Device not found in build destinations"
	@echo ""
	@echo "Checking device connectivity..."
	@xcrun devicectl list devices 2>/dev/null | grep -q "R's 15\|$(DEVICE_ID)" && \
		echo "✅ Device is connected" || \
		echo "❌ Device not found in connected devices (may still work for building)"

# List available simulators
.PHONY: simulators
simulators:
	@echo "📱 Available Simulators:"
	@echo "Current SIM=$(SIM) using ID: $(SIMULATOR_ID)"
	@echo ""
	@xcrun simctl list devices

# Show project info
.PHONY: info
info:
	@echo "📋 Project Information:"
	@echo "  App Name: $(APP_NAME)"
	@echo "  App Version: $(APP_VERSION)"
	@BUILD_NUM=$$(cat build/BUILD_NUMBER 2>/dev/null || echo "1"); \
	echo "  Build Number: $$BUILD_NUM"
	@echo "  Bundle ID: $(BUNDLE_ID)"
	@echo "  Scheme: $(SCHEME)"
	@echo "  Project: $(PROJECT)"
	@echo "  Minimum iOS Deployment Target: $(DEPLOYMENT_TARGET)"
	@echo "  Minimum Device Required: $(MIN_DEVICE)"
	@echo ""
	@echo "📱 Physical Devices:"
	@echo "  iPhone:"
	@echo "    Name: $(IPHONE_DEVICE_NAME)"
	@echo "    ID: $(IPHONE_DEVICE_ID)"
	@echo "  iPad:"
	@echo "    Name: $(IPAD_DEVICE_NAME)"
	@echo "    ID: $(IPAD_DEVICE_ID)"
	@echo "  Default Device (DEVICE=$(DEVICE)): $(DEVICE_NAME) ($(DEVICE_ID))"
	@echo ""
	@echo "🖥️  Simulator:"
	@echo "  Default (SIM=$(SIM)): $(SIM)"
	@echo "  ID: $(SIMULATOR_ID)"

# Start InjectionIII app for hot reloading
.PHONY: injection-start
injection-start:
	@echo "🔥 Starting InjectionIII for hot reloading..."
	@if [ -d "/Applications/InjectionIII.app" ]; then \
		open -a InjectionIII; \
		echo "✅ InjectionIII started successfully"; \
		echo "💡 Once your app is running, select 'File > Open Project...' in InjectionIII"; \
		echo "💡 Then choose your project directory: $(PWD)"; \
	else \
		echo "❌ InjectionIII not found in /Applications/"; \
		echo "Please install InjectionIII from the Mac App Store or GitHub"; \
	fi

# Stop InjectionIII app
.PHONY: injection-stop
injection-stop:
	@echo "🛑 Stopping InjectionIII..."
	@osascript -e 'quit app "InjectionIII"' 2>/dev/null || echo "InjectionIII was not running"
	@echo "✅ InjectionIII stopped"

# Simulator run with hot reloading - build, run and start InjectionIII
.PHONY: run-hot
run-hot: setup injection-start run
	@echo "🔥 Development environment ready with hot reloading!"
	@echo ""
	@echo "📋 Next steps:"
	@echo "1. Your app should be running in the simulator"
	@echo "2. InjectionIII should be open"
	@echo "3. In InjectionIII, go to 'File > Open Project...' and select: $(PWD)"
	@echo "4. Make changes to your Swift files - they should reload automatically!"
	@echo ""
	@echo "💡 Tips:"
	@echo "- Changes to SwiftUI views will be reflected immediately"
	@echo "- You can use the InjectionIII menu to enable/disable injection"
	@echo "- Check the InjectionIII console for any injection errors"

# Archive for release
.PHONY: archive
archive: increment-build
	@NEW_BUILD_NUM=$$(cat build/BUILD_NUMBER 2>/dev/null || echo "1"); \
	echo "📦 Archiving $(APP_NAME) v$(APP_VERSION) build $$NEW_BUILD_NUM..."; \
	xcodebuild archive \
		-project $(PROJECT) \
		-scheme $(SCHEME) \
		-archivePath ./build/$(APP_NAME).xcarchive \
		-configuration Release \
		-destination "generic/platform=iOS" \
		DEVELOPMENT_TEAM=$(TEAM_ID) \
		MARKETING_VERSION=$(APP_VERSION)
	@echo "✅ Archive created at ./build/$(APP_NAME).xcarchive"

# Upload existing archive to TestFlight
.PHONY: upload-testflight
upload-testflight:
	@if [ -z "$(ARCHIVE)" ]; then \
		echo "❌ ARCHIVE path is required. Usage: make upload-testflight ARCHIVE=./build/MySwiftApp.xcarchive"; \
		echo "💡 Or use default archive: make upload-testflight"; \
		echo ""; \
		if [ -f "./build/$(APP_NAME).xcarchive/Info.plist" ]; then \
			echo "📦 Found default archive: ./build/$(APP_NAME).xcarchive"; \
			ARCHIVE="./build/$(APP_NAME).xcarchive"; \
		else \
			echo "❌ No default archive found at ./build/$(APP_NAME).xcarchive"; \
			echo "💡 Build an archive first with: make archive"; \
			exit 1; \
		fi; \
	fi
	@echo "📤 Uploading archive to TestFlight: $(ARCHIVE)"
	@if [ ! -d "$(ARCHIVE)" ]; then \
		echo "❌ Archive not found: $(ARCHIVE)"; \
		echo "💡 Build an archive first with: make archive"; \
		exit 1; \
	fi
	@echo "🔍 Validating archive..."
	@xcodebuild -exportArchive \
		-archivePath "$(ARCHIVE)" \
		-exportPath "./build/upload" \
		-exportOptionsPlist "./ExportOptions.plist" \
		-allowProvisioningUpdates
	@echo "📤 Uploading to App Store Connect..."
	@xcrun altool --upload-app \
		-f "./build/upload/$(APP_NAME).ipa" \
		-t ios \
		--apiKey "$(APP_STORE_CONNECT_API_KEY_ID)" \
		--apiIssuer "$(APP_STORE_CONNECT_ISSUER_ID)" \
		--verbose
	@echo "✅ Upload completed! Check App Store Connect for processing status."
	@echo "📱 TestFlight: https://appstoreconnect.apple.com/apps"

# Create and push git tag for post TestFlight deployment
.PHONY: create-tag
create-tag:
	@if [ -z "$(VERSION)" ]; then \
		VERSION=$(APP_VERSION); \
		echo "📋 Using default version: $$VERSION (from APP_VERSION)"; \
	else \
		VERSION=$(VERSION); \
	fi; \
	echo "🏷️  Creating git tag local/v$$VERSION..."; \
	if git rev-parse local/v$$VERSION >/dev/null 2>&1; then \
		echo "❌ Tag local/v$$VERSION already exists"; \
		exit 1; \
	fi; \
	git tag local/v$$VERSION; \
	echo "📤 Pushing tag to origin..."; \
	git push origin local/v$$VERSION; \
	echo "✅ Tag local/v$$VERSION created and pushed!"; \
	echo "🚀 Git tag created for manual deployment"

# Complete local release workflow: archive, upload to TestFlight and create tag
.PHONY: local-release
local-release: archive upload-testflight create-tag
	@echo "🎉 Local release completed successfully!"
	@echo "📦 Archive created at: ./build/$(APP_NAME).xcarchive"
	@echo "🏷️  Git tag created: local/v$(APP_VERSION)"
	@echo "📤 Uploaded to TestFlight successfully!"
	@echo ""
	@echo "📋 Next steps:"
	@echo "  • Check App Store Connect for processing status"
	@echo "  • Monitor TestFlight: https://appstoreconnect.apple.com/apps"
	@open "$(APP_STORE_CONNECT_URL)/testflight"

# Trigger build and release via Xcode Cloud to TestFlight
.PHONY: xcode-cloud-release
xcode-cloud-release:
	@echo "☁️  Starting Xcode Cloud build and release for $(APP_NAME) v$(APP_VERSION)..."; \
	echo "🏷️  Creating release tag v$(APP_VERSION)..."; \
	if git rev-parse v$(APP_VERSION) >/dev/null 2>&1; then \
		echo "⚠️  Tag v$(APP_VERSION) already exists, deleting and recreating tag"; \
		git tag -d v$(APP_VERSION); \
		git push origin :refs/tags/v$(APP_VERSION) 2>/dev/null || true; \
	fi; \
	git tag v$(APP_VERSION); \
	echo "📤 Pushing tag to trigger Xcode Cloud release..."; \
	git push origin v$(APP_VERSION); \
	echo "✅ Tag v$(APP_VERSION) created and pushed!"; \
	echo "☁️  Xcode Cloud build initiated!"; \
	echo "💡 The build will automatically deploy to TestFlight when complete"; \
	echo ""; \
	echo "📋 Next steps:"; \
	echo "  • Check Xcode Cloud for build status"; \
	echo "  • Monitor progress at the links below"; \
	echo "📱 Opening Xcode Cloud dashboard..."; \
	open "$(APP_STORE_CONNECT_URL)/ci"
