# Vibe Coding Setup for iOS/Mac Apps in Swift with VS Code

This repository demonstrates "vibe coding" for iOS/Swift development in VS Code—emphasizing fast, AI-assisted iterations with hot-reloading, automated builds via Makefile, and XcodeGen project management. You'll use VS Code for editing with GitHub Copilot, while leveraging Xcode for simulators and deployment.

**Key Features:**

- **XcodeGen Project Management**: Define your Xcode project in `project.yml` and generate `.xcodeproj` files programmatically
- **Makefile Build System**: Comprehensive build, test, and deployment commands (820+ lines)
- **AI-Assisted Development**: Multi-model approach with Claude Sonnet 4+ for initial setup and Grok Code Fast 1 for ongoing development
- **Hot-Reloading**: InjectionIII integration for live SwiftUI updates
- **Swift 6.0**: Modern concurrency with strict concurrency checking enabled
- **Multi-Platform**: iOS 18.0+ support with Mac Catalyst compatibility

Tested with Swift 6.0, Xcode 26+, macOS Tahoe+, October 2025.

## Project Structure

```text
vibe-coding-ios-swift/
├── Sources/
│   ├── MySwiftApp/          # Main iOS app source code
│   └── MySwiftAppCLI/        # Command-line interface
├── Tests/
│   └── MySwiftAppTests/      # Unit and integration tests
├── docs/                     # Documentation
│   ├── APP_ICON_SETUP.md
│   ├── APP_STORE_SCREENSHOTS.md
│   └── SCREENSHOTS_QUICK_REF.md
├── scripts/                  # Build and utility scripts
│   ├── generate-icons.sh
│   └── resize-screenshots.sh
├── .vscode/                  # VS Code workspace settings
│   ├── settings.json         # Editor and formatter config
│   └── extensions.json       # Recommended extensions
├── .github/
│   └── copilot-instructions.md  # AI coding guidelines
├── project.yml               # XcodeGen project definition
├── makefile                  # Build automation (820+ lines)
├── Info.plist                # App metadata
└── ExportOptions.plist       # App Store export config
```

## Prerequisites

- **macOS Tahoe or later**
- **Xcode 26+** - Download from App Store or [developer.apple.com](https://developer.apple.com)
- **Homebrew** - Install via:

  ```bash
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ```

- **GitHub Copilot subscription** - Pro, Pro+, Business, or Enterprise (includes access to Claude Sonnet 4+ and Grok Code Fast 1)
- **Apple Developer Account** - Required for physical device testing and deployment

## Installation

### Step 1: Install VS Code

Download and install from [code.visualstudio.com](https://code.visualstudio.com).

### Step 2: Install Homebrew Packages

These provide Swift tooling, formatting, and build integration. Run in Terminal:

```bash
brew install swift swiftformat xcode-build-server xcbeautify xcodegen
```

**Package Descriptions:**

- **swift**: Core Swift compiler and tools
- **swiftformat**: Auto-formats Swift code
- **xcode-build-server**: Enables build/run/debug via SweetPad extension
- **xcbeautify**: Pretty-prints xcodebuild output
- **xcodegen**: Generates Xcode project from `project.yml` spec

### Step 3: Install VS Code Extensions

This repository includes `.vscode/extensions.json` with 10 recommended extensions. Open the workspace in VS Code and install them via the Extensions panel notification, or manually install these extensions:

- **GitHub Copilot** (`github.copilot`): AI code completion and suggestions
- **GitHub Copilot Chat** (`github.copilot-chat`): Chat interface with Claude Sonnet 4+ support
- **GitHub Actions** (`github.vscode-github-actions`): CI/CD workflow support
- **GitHub Pull Requests and Issues** (`github.vscode-pull-request-github`): PR and issue management
- **CodeLLDB** (`vadimcn.vscode-lldb`): Native debugger for Swift/C++
- **LLDB DAP** (`llvm-vs-code-extensions.lldb-dap`): Debug Adapter Protocol for LLDB
- **Makefile Tools** (`ms-vscode.makefile-tools`): Makefile IntelliSense and build integration
- **YAML** (`redhat.vscode-yaml`): YAML language support with validation
- **SweetPad** (`sweetpad.sweetpad`): Integrates xcodebuild for building/running/debugging in VS Code
- **Swift** (`swiftlang.swift-vscode`): Official Swift extension with SourceKit-LSP for syntax highlighting, autocompletion, go-to-definition, and debugging

### Step 4: Install InjectionIII (for Hot-Reloading)

InjectionIII enables live SwiftUI updates in the simulator without rebuilds.

**Installation Options:**

- **Via Mac App Store**: Search "InjectionIII" and install (free)
- **Via GitHub**: Download from [github.com/johnno1962/InjectionIII/releases](https://github.com/johnno1962/InjectionIII/releases), unzip to `/Applications`

Launch InjectionIII (menu bar icon appears). Grant Full Disk Access in System Settings > Privacy & Security if prompted.

## Configuration

### VS Code Workspace Settings

This repository includes `.vscode/settings.json` with optimized settings:

- **Formatter**: Swift extension (`swiftlang.swift-vscode`) set as default
- **Format on Save**: Enabled for automatic code formatting
- **File Exclusions**: Hides build artifacts (`.build`, `.swiftpm`, `xcuserdata`)
- **GitHub Copilot**: Enabled for all file types including Swift
- **Max Requests**: Set to 45 for extended Copilot chat sessions

### Configure GitHub Copilot with Multiple AI Models

1. Ensure Copilot is active (sign in via VS Code's Accounts menu)
2. Access different AI models via the model picker:
   - Open Copilot Chat (`Cmd+Shift+I` or click chat icon)
   - Use the model picker dropdown to switch between models:
     - **"Claude Sonnet 4.5"** - For initial project setup and complex architecture
     - **"Grok Code Fast 1"** - For ongoing development and fast iterations
   
   **Recommended Workflow:**
   - Optionally use Grok 4 (via web interface at x.com/grok, outside VS Code) to generate a comprehensive prompt for your app idea
   - Start with Claude Sonnet 4.5 for project creation from this template
   - Switch to Grok Code Fast 1 for daily coding tasks
   - Return to Claude Sonnet 4.5 for complex architectural challenges

### Configure InjectionIII

1. Open InjectionIII menu bar > "Open Project" > Select your Xcode project folder
2. In your app's entry point (e.g., `@main` struct):

   ```swift
   #if DEBUG
   Bundle(path: "/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle")?.load()
   #endif
   ```

3. Note: `EMIT_FRONTEND_COMMAND_LINES = YES` is already configured in `project.yml` for Debug builds

### Generate Xcode Project

This project uses XcodeGen to manage the Xcode project. Generate it from `project.yml`:

```bash
xcodegen generate
```

Or use the Makefile:

```bash
make setup
```

This creates `MySwiftApp.xcodeproj` from the `project.yml` specification.

## Usage

### Opening Your Project

In VS Code: `File > Open Folder` > Select this repository's root directory.

### Build System with Makefile

This project includes an 820-line Makefile with comprehensive build automation. View all commands:

```bash
make help
```

**Common Commands:**

```bash
# Project Setup
make setup              # Generate Xcode project from project.yml
make clean              # Clean build artifacts

# Testing
make test               # Run tests on simulator
make test-device        # Run tests on physical device
make test-coverage      # Generate code coverage report

# Simulator Commands
make build              # Build for iOS Simulator
make run                # Build, install and run app on simulator
make run-2-sims         # Run on both iPhone & iPad simulators
make run-hot            # Build and run with InjectionIII hot-reloading

# Physical Device Commands  
make dev-build          # Build for device
make dev-run            # Build and run on device (DEVICE=iphone|ipad)
make dev-install        # Install on device without debugging

# App Store Distribution
make archive            # Create App Store archive
make upload-testflight  # Upload to TestFlight
```

**Examples:**

```bash
# Run on iPad simulator
make run SIM=ipad

# Run on physical iPhone
make dev-run DEVICE=iphone

# Run tests with coverage
make test-coverage
```

### Hot-Reloading with InjectionIII

1. Start app in Xcode simulator (or via `make run-hot`)
2. Edit SwiftUI code in VS Code and save
3. InjectionIII injects changes—see live updates in simulator without rebuilding

**Tip**: Prompt Copilot for code, apply changes, then hot-reload for instant feedback.

### AI-Assisted Vibe Coding with GitHub Copilot

#### Inline Autocompletions

Type in `.swift` files; GitHub Copilot suggests Swift 6.0-compliant code with modern async/await patterns.

#### Chat Interface

Open Copilot Chat (`Cmd+Shift+I`):

**For Initial Setup**: Select "Claude Sonnet 4.5"
- **Project architecture**: "Create the complete app structure using TCA and Core Data"
- **Complex features**: "Implement advanced iCloud sync with conflict resolution"
- **Major refactoring**: "Refactor the entire app to use async/await throughout"

**For Ongoing Development**: Select "Grok Code Fast 1"
- **Fast code generation**: "Add a new SwiftUI view for user settings"
- **Quick refactoring**: "Refactor this class to use async/await instead of completion handlers"
- **Debugging**: "Fix the memory leak in this view controller"
- **Feature additions**: "Add pull-to-refresh functionality to the list view"

**Apply Suggestions**: Accept diffs inline or via chat panel

**Example Prompts:**

```text
In this file, add @MainActor to the ViewModel and fix concurrency warnings. Use Swift 6.0.
```

```text
Plan a TCA feature for user authentication with async/await, then implement in SwiftUI.
```

### Copilot Instructions

This repository includes `.github/copilot-instructions.md` with Swift development guidelines that GitHub Copilot automatically follows:

- **Code Quality Standards**: Swift API Design Guidelines, descriptive naming, single-purpose functions
- **Swift Best Practices**: Optional handling, type safety, protocol-oriented programming
- **iOS/macOS Development**: SwiftUI, MVVM pattern, async/await
- **Memory Management**: Avoid retain cycles, proper weak/unowned usage
- **Performance**: Efficient algorithms, lazy properties, GCD for concurrency
- **Testing**: XCTest unit tests, TDD approach, edge case coverage
- **Security**: No hardcoded secrets, input validation, HTTPS communication

Copilot uses these instructions to generate code that aligns with project standards.

## Generating Effective Prompts for Copilot

To maximize effectiveness with Claude Sonnet 4+ and Grok Code Fast 1, craft prompts that are specific, contextual, and iterative. Consider using Grok 4 (via web interface outside VS Code) to generate detailed prompts for complex initial setups.

### Prompt Engineering Tips

- **Be Specific**: Include app spec, APIs, or code snippets
  - ✅ "Refactor this UserManager class to add caching with TTL of 5 minutes"
  - ❌ "Improve this code"

- **Provide Context**: Mention Swift version, frameworks, and requirements
  - "Use Swift 6.0 concurrency"
  - "Integrate with Core Data"
  - "Handle loading/errors/offline states"

- **Agentic/Step-by-Step**: Break complex tasks into plans
  - "First create the data model, then the view model, then the SwiftUI view"

- **Iterate**: Start simple, then refine
  - "Improve this generated code for performance"
  - "Add error handling to the previous implementation"

- **iOS Best Practices**: Specify platform requirements
  - "Make it hot-reloadable with InjectionIII"
  - "Optimize for iOS 18+"
  - "Support both iPhone and iPad"

- **Avoid Vagueness**: Provide detailed specifications
  - ✅ "Generate a SwiftUI note-taking app with these features: [details]"
  - ❌ "Make an app"

### Example: Complete App Generation

**App Spec**: Build a basic iOS note-taking app using SwiftUI, TCA (Composable Architecture), and Core Data. Features: Add/edit/delete notes, searchable list, async save/load with error handling, loading states. Use Swift 6.0 concurrency.

**Prompt for Copilot Chat:**

```text
Using TCA and SwiftUI in Swift 6.0, generate a complete note-taking app feature with Core Data integration. 

App Spec:
- Model: Note entity with id, title, content, timestamp
- Views: NavigationStack with searchable List of notes; detail view for edit; add button
- Actions: Load notes async, add/edit/delete with persistence, handle errors (alert on save fail)
- States: Loading, loaded with notes array, error message
- Reducer: Use async/await for Core Data ops; include pull-to-refresh

Output full code: Feature reducer, views, and Core Data setup. Make it modular for an existing Xcode project and hot-reloadable with InjectionIII.
```

**Expected Flow**: Copilot generates code diffs/files → Apply to your project → Hot-reload in simulator → Iterate with follow-up prompts.

## Recommended AI Model Workflow

For optimal iOS app development, use different AI models for different phases of development:

### Optional: App Prompt Generation with Grok 4

For the best results, consider using **Grok 4** (accessed via web interface at x.com/grok, outside VS Code) to generate a comprehensive, detailed prompt before starting your project with Claude Sonnet 4+. Grok 4 excels at:
- Understanding high-level app concepts and requirements
- Generating well-structured, detailed prompts with comprehensive specifications
- Creating prompts that help Claude Sonnet 4+ produce better initial project structures
- Articulating technical requirements and architectural patterns clearly

This optional step, done outside your VS Code environment, helps Claude Sonnet 4+ receive better-formed prompts, resulting in higher quality initial code generation.

### Initial Project Setup

Use **Claude Sonnet 4+** (via GitHub Copilot) for creating your Swift app project from scratch. Claude Sonnet 4+ excels at:
- Setting up the initial project structure from this repository skeleton
- Creating comprehensive app architecture
- Establishing proper patterns and best practices
- Setting up Core Data, TCA, or other foundational frameworks

### Ongoing Development

Use **Grok Code Fast 1** for the rest of your coding after initial setup. Grok Code Fast 1 is optimized for:
- Fast code generation and iterations
- Refactoring existing code
- Adding new features to established projects
- Bug fixes and minor enhancements

### Complex Features

For very complex parts or when you encounter challenging architectural decisions, **switch back to Claude Sonnet 4+**. Use Claude Sonnet 4+ when you need:
- Deep architectural refactoring
- Complex algorithm implementation
- Advanced concurrency patterns
- Resolving difficult bugs or performance issues

### Workflow

0. **Optional - Use Grok 4 for Prompt Generation**: Generate a detailed, comprehensive prompt for your app
   - Open Grok 4 via web interface (e.g., x.com/grok) outside VS Code
   - Describe your app idea in simple terms
   - Ask Grok 4 to generate a detailed prompt for Claude Sonnet 4+ that includes all technical specifications, architecture patterns, and requirements
   - Copy the generated prompt for use in the next step with Claude Sonnet 4+ in VS Code

1. **Start with Claude Sonnet 4+**: Create your initial Swift app project, reusing the skeleton from this git repository
   - Open Copilot Chat (`Cmd+Shift+I`) and select "Claude Sonnet 4.5"
   - Use the detailed prompt generated by Grok 4, or describe your app with full specifications, tech stack (Swift 6.0, SwiftUI, TCA, etc.)
   - Let Claude Sonnet 4+ set up the project structure, architecture patterns, and foundational code
   
2. **Switch to Grok Code Fast 1**: For all subsequent coding tasks
   - In Copilot Chat, select "Grok Code Fast 1" from the model picker
   - Use for feature additions, refactoring, and day-to-day development
   
3. **Return to Claude Sonnet 4+ when needed**: For complex architectural challenges
   - Switch back to "Claude Sonnet 4.5" for sophisticated problems
   - Once resolved, return to Grok Code Fast 1 for continued development
   
4. **Review and refine** all generated code, then hot-reload with InjectionIII

### Example: Using Grok 4 for Prompt Generation

Before starting your project in VS Code, use Grok 4 via web interface (e.g., x.com/grok) to create a detailed prompt that Claude Sonnet 4+ can use:

```text
I want to create an iOS app. My idea is: "A habit tracker with daily reminders, progress charts, and iCloud sync"

Please generate a comprehensive, detailed prompt for Claude Sonnet 4+ that will help it create the initial project setup using this vibe-coding-ios-swift-template repository. The prompt should include:
- Complete technical specifications (Swift 6.0, SwiftUI, TCA)
- Detailed feature requirements
- Architecture patterns to follow
- Data model structure
- Integration requirements (Core Data, CloudKit, notifications)
- Error handling and state management approach
- iOS best practices to follow

Make the prompt specific enough that Claude Sonnet 4+ can generate a well-structured, production-ready initial codebase.
```

Grok 4 will then generate a detailed prompt that you can copy and paste into VS Code's Copilot Chat with Claude Sonnet 4+ in the next step. This helps Claude Sonnet 4+ generate better-structured code from the start.

### Example: Initial Project Setup with Claude Sonnet 4+

```text
I want to create an iOS app from scratch using this vibe-coding-ios-swift-template repository skeleton.

My app idea: [Describe your app - e.g., "A habit tracker with daily reminders, progress charts, and iCloud sync"]

Using this existing project structure, please:
- Set up the complete app architecture using Swift 6.0, SwiftUI, and TCA (The Composable Architecture)
- Create the foundational data models and Core Data/CloudKit setup
- Establish proper folder structure following the existing patterns
- Implement state management with TCA
- Set up error handling and loading states
- Configure for hot-reloading with InjectionIII
- Follow iOS 18+ best practices

Start with the core architecture and main features. I'll use Grok Code Fast 1 for subsequent iterations and additions.
```

### Example: Ongoing Development with Grok Code Fast 1

After your initial setup with Claude Sonnet 4+, use Grok Code Fast 1 for faster iterations:

```text
Add a new feature to display weekly progress charts in the habit tracker.
- Create a new SwiftUI view for the chart
- Use Swift Charts framework
- Fetch data from existing Core Data store
- Add navigation from the main list
- Include loading and error states
```

### Why This Multi-Model Approach

- **Grok 4 for Prompt Generation** (Optional): Excellent at translating high-level app ideas into detailed, structured prompts that help Claude Sonnet 4+ generate better initial code
- **Claude Sonnet 4+ for Setup**: Superior at understanding complex architectural requirements and establishing solid foundations
- **Grok Code Fast 1 for Development**: Optimized for speed and efficiency in day-to-day coding tasks
- **Strategic Switching**: Use the right tool for the right job—prompt generation with Grok 4, comprehensive planning with Claude, fast iterations with Grok Code Fast 1
- **Cost Effective**: Reserve Claude Sonnet 4+ for where it matters most while using faster models for routine work

This multi-model approach combines intelligent prompt generation, strategic architecture planning, and rapid implementation for faster, higher-quality iOS app development.

## Documentation

Additional documentation is available in the `docs/` directory:

- **[APP_ICON_SETUP.md](docs/APP_ICON_SETUP.md)**: Guide for creating and configuring app icons
- **[APP_STORE_SCREENSHOTS.md](docs/APP_STORE_SCREENSHOTS.md)**: Screenshot requirements and guidelines
- **[SCREENSHOTS_QUICK_REF.md](docs/SCREENSHOTS_QUICK_REF.md)**: Quick reference for screenshot specifications

## Scripts

Utility scripts are available in the `scripts/` directory:

- **`generate-icons.sh`**: Automated app icon generation from source image
- **`resize-screenshots.sh`**: Batch resize screenshots for App Store submission

## Tips for Maximum Productivity

- **Cmd+Tab Workflow**: Switch between VS Code (editing) and Xcode Simulator (testing)
- **Model Selection**: Use Grok 4 (via web interface outside VS Code) for prompt generation, Claude Sonnet 4+ for initial setup and complex features, Grok Code Fast 1 for everything else
- **Optimize Prompts**: Consider using Grok 4 (outside VS Code) to generate detailed prompts for complex features; test with small features and always review AI outputs regardless of model
- **Code Review**: Run `swiftlint` or Xcode analyzer on AI-generated code
- **Use Makefile**: Leverage build automation instead of manual xcodebuild commands
- **XcodeGen**: Keep `project.yml` as source of truth; regenerate `.xcodeproj` as needed
- **Hot-Reload**: Maximize iteration speed with InjectionIII for SwiftUI views
- **Version Control**: Commit `project.yml` and `.xcodeproj`
- **Extensions**: Keep VS Code extensions updated for latest features
- **Copilot Instructions**: Customize `.github/copilot-instructions.md` for project-specific guidelines

## Project Configuration

- **Swift Version**: 6.0 with strict concurrency enabled
- **Deployment Target**: iOS 18.0+
- **Platforms**: iPhone, iPad, Mac Catalyst
- **Bundle ID**: MY_BUNDLE_ID
- **Build System**: XcodeGen + Makefile
- **Dependencies**: ZipArchive (via Swift Package Manager)
- **Testing**: XCTest with unit and integration tests

## Contributing

This repository follows Swift best practices defined in `.github/copilot-instructions.md`. When contributing:

1. Use XcodeGen to modify project structure (edit `project.yml`, then run `make setup`)
2. Follow Swift API Design Guidelines
3. Write unit tests for new functionality
4. Use Swift 6.0 concurrency patterns (async/await, actors)
5. Ensure code passes `swiftlint` and Xcode analyzer
6. Test with InjectionIII hot-reloading where applicable

## License

See [LICENSE](LICENSE) file for details.

---

**Questions or Issues?** Check the documentation in `docs/` or review `.github/copilot-instructions.md` for coding guidelines. For build issues, consult `make help` for available commands.

This setup makes VS Code a Swift vibe-coding powerhouse—AI-driven edits, hot-reloads, and automated builds. Happy coding! 🚀
