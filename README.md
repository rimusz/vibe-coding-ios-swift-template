# 🚀 Vibe Coding iOS/Mac Swift Template

A production-ready template for building iOS and macOS applications with Swift, designed for modern development with VS Code, GitHub Copilot Agent, and Claude Sonnet 4.x.

## ✨ Features

- 🎯 **Swift Package Manager** - Modern dependency management
- 🧪 **XCTest Framework** - Comprehensive testing setup
- 🤖 **GitHub Copilot Agent** - AI-powered coding assistance with custom agents
- 🛠️ **VS Code Integration** - Optimized settings and tasks
- 📱 **iOS/macOS Support** - Cross-platform development
- 🎨 **Best Practices** - Following Swift API Design Guidelines
- 🔍 **Type-Safe** - Leveraging Swift's powerful type system
- ⚡ **Async/Await** - Modern concurrency patterns

## 📋 Prerequisites

- **macOS**: 13.0 or later (for macOS development)
- **Xcode**: 15.0 or later
- **Swift**: 5.9 or later
- **VS Code**: Latest version
- **GitHub Copilot**: Active subscription

### Required VS Code Extensions

Install the recommended extensions when prompted, or manually install:

- **GitHub Copilot** (`github.copilot`)
- **GitHub Copilot Chat** (`github.copilot-chat`)
- **Swift Language Support** (`sswg.swift-lang`)
- **CodeLLDB** (`vadimcn.vscode-lldb`)

## 🚀 Getting Started

### 1. Use This Template

Click the "Use this template" button on GitHub to create a new repository from this template.

### 2. Clone Your Repository

```bash
git clone https://github.com/YOUR-USERNAME/YOUR-REPO-NAME.git
cd YOUR-REPO-NAME
```

### 3. Open in VS Code

```bash
code .
```

### 4. Install Extensions

VS Code will prompt you to install the recommended extensions. Click "Install All" to get started.

### 5. Build the Project

```bash
swift build
```

### 6. Run Tests

```bash
swift test
```

### 7. Run the CLI Demo

```bash
swift run MySwiftAppCLI
```

## 🏗️ Project Structure

```
.
├── .github/
│   └── agents/              # GitHub Copilot Agent configurations
│       ├── swift-developer.md    # Swift development expert
│       └── code-reviewer.md      # Code review assistant
├── .vscode/
│   ├── extensions.json      # Recommended extensions
│   ├── settings.json        # VS Code settings
│   ├── tasks.json          # Build and test tasks
│   └── launch.json         # Debug configurations
├── Sources/
│   ├── MySwiftApp/         # Main library code
│   │   └── MySwiftApp.swift
│   └── MySwiftAppCLI/      # CLI executable
│       └── main.swift
├── Tests/
│   └── MySwiftAppTests/    # Test files
│       └── MySwiftAppTests.swift
├── Package.swift           # Swift Package Manager manifest
└── README.md              # This file
```

## 🤖 GitHub Copilot Agents

This template includes pre-configured GitHub Copilot agents to assist with Swift development:

### Swift Developer Agent

Specialized in writing idiomatic Swift code following Apple's best practices. Use it for:

- Writing new features
- Implementing Swift patterns
- SwiftUI and UIKit development
- Async/await and concurrency

### Code Reviewer Agent

Provides thorough code reviews focusing on:

- Code quality and best practices
- Performance optimization
- Memory management
- Security considerations

To use an agent in GitHub Copilot Chat, type `@swift-developer` or `@code-reviewer` followed by your question.

## 🧪 Testing

The template includes a comprehensive test suite using XCTest:

```bash
# Run all tests
swift test

# Run tests with verbose output
swift test --verbose

# Run specific test
swift test --filter GreetingServiceTests
```

### Test Coverage

The example code includes tests for:

- Unit tests for individual components
- Async/await testing patterns
- Model serialization (Codable)
- Equality and identity

## 🔨 Development Tasks

VS Code tasks are pre-configured for common operations:

- **Swift Build** (⌘+Shift+B): Compile the project
- **Swift Test**: Run all tests
- **Swift Run**: Execute the CLI
- **Clean**: Remove build artifacts

Access tasks via:
- Command Palette: `Tasks: Run Task`
- Keyboard: `⌘+Shift+B` (default build task)

## 🐛 Debugging

Two debug configurations are available:

1. **Debug Swift App**: Debug the main application
2. **Debug Swift Tests**: Debug test execution

Start debugging:
- Press `F5` or use the Debug panel
- Set breakpoints by clicking in the gutter
- Use the Debug Console for LLDB commands

## 📝 Code Style & Best Practices

This template follows Swift best practices:

### Naming Conventions

- **Types**: `PascalCase` (e.g., `GreetingService`, `Person`)
- **Functions/Variables**: `camelCase` (e.g., `fetchPerson`, `firstName`)
- **Constants**: `camelCase` (e.g., `maxRetries`)

### Code Organization

- Use `// MARK: -` for logical sections
- Group related functionality together
- Keep files focused and single-purpose

### Swift Patterns

- Prefer `struct` over `class` for value types
- Use `let` instead of `var` when possible
- Use `guard` for early exits
- Leverage protocol-oriented programming
- Handle errors explicitly with `Result` or `throws`

### Async/Await

```swift
// Modern concurrency with async/await
func fetchData() async throws -> Data {
    let (data, _) = try await URLSession.shared.data(from: url)
    return data
}
```

## 🔧 Customization

### Renaming the Package

1. Update `Package.swift` - change the `name` property
2. Rename directories in `Sources/` and `Tests/`
3. Update imports in Swift files

### Adding Dependencies

Edit `Package.swift` to add external dependencies:

```swift
dependencies: [
    .package(url: "https://github.com/example/package.git", from: "1.0.0"),
],
targets: [
    .target(
        name: "MySwiftApp",
        dependencies: [
            .product(name: "PackageName", package: "package"),
        ]),
]
```

### iOS/macOS Deployment Targets

Update the `platforms` array in `Package.swift`:

```swift
platforms: [
    .iOS(.v17),      // Change iOS version
    .macOS(.v14)     // Change macOS version
]
```

## 🤝 Using with Claude Sonnet 4.x

When working with Claude Sonnet 4.x for code generation and review:

1. **Context Sharing**: Share relevant code files and the project structure
2. **Specific Requests**: Be clear about what you want to build or improve
3. **Iterative Development**: Use Claude for code review and refinement
4. **Best Practices**: Ask Claude to ensure code follows Swift best practices
5. **Testing**: Request test generation for new features

### Example Prompts

- "Review this Swift code for memory leaks and suggest improvements"
- "Generate a SwiftUI view for displaying a list of persons"
- "Write tests for the DataService actor covering edge cases"
- "Refactor this code to use protocol-oriented programming"

## 📚 Resources

- [Swift.org](https://swift.org/) - Official Swift documentation
- [Swift API Design Guidelines](https://swift.org/documentation/api-design-guidelines/)
- [SwiftUI Documentation](https://developer.apple.com/documentation/swiftui)
- [Async/Await in Swift](https://docs.swift.org/swift-book/LanguageGuide/Concurrency.html)
- [GitHub Copilot Documentation](https://docs.github.com/en/copilot)

## 📄 License

This template is available under the MIT License. Feel free to use it for any purpose.

## 🙏 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 💡 Tips for Vibe Coding

**Vibe coding** is about maintaining flow and productivity with AI assistance:

1. **Let AI Handle Boilerplate**: Use Copilot for repetitive code
2. **Focus on Architecture**: Spend time on design, let AI fill details
3. **Rapid Prototyping**: Quickly iterate with AI suggestions
4. **Continuous Testing**: Write tests alongside features
5. **Stay in Flow**: Use VS Code tasks and shortcuts to minimize context switching
6. **Trust but Verify**: Review AI-generated code for correctness

Happy coding! 🎉