# 🚀 Quick Start Guide

Get up and running with this template in 5 minutes!

## Prerequisites Checklist

- [ ] macOS 13.0 or later
- [ ] Xcode 15.0 or later installed
- [ ] VS Code installed
- [ ] GitHub Copilot subscription active

## Step-by-Step Setup

### 1. Create Your Project (30 seconds)

Click the green "Use this template" button on GitHub and create a new repository.

### 2. Clone Your Repo (30 seconds)

```bash
git clone https://github.com/YOUR-USERNAME/YOUR-REPO-NAME.git
cd YOUR-REPO-NAME
```

### 3. Open in VS Code (10 seconds)

```bash
code .
```

### 4. Install Extensions (1 minute)

When prompted, click "Install All" to install recommended extensions:
- GitHub Copilot
- GitHub Copilot Chat
- Swift Language Support
- CodeLLDB

### 5. Verify Swift Installation (10 seconds)

```bash
swift --version
```

You should see Swift 5.9 or later.

### 6. Build the Project (30 seconds)

In VS Code:
- Press `⌘+Shift+B` (or `Ctrl+Shift+B` on Windows/Linux)
- Or run in terminal: `swift build`

### 7. Run Tests (30 seconds)

```bash
swift test
```

All tests should pass! ✅

### 8. Run the Demo CLI (10 seconds)

```bash
swift run MySwiftAppCLI
```

You should see output like:

```
=== MySwiftApp Demo ===

Hello, World!
Hello, Swift Developer!
Welcome, Swift Developer!

=== Person Model Demo ===

Person 1: John Doe (ID: ...)
Person 2: Jane Smith (ID: ...)

=== DataService Demo ===

Fetched: John Doe
Total persons in cache: 2
  - John Doe
  - Jane Smith
```

## Next Steps

### Customize the Template

1. **Rename the project** - Edit `Package.swift` and update the name
2. **Update README** - Personalize the documentation
3. **Explore the code** - Check out the example implementations in `Sources/`

### Start Coding with Copilot

1. Open any `.swift` file
2. Press `⌘+I` (or `Ctrl+I`) to open Copilot Chat
3. Try asking: "Explain how the GreetingService works"
4. Start typing and let Copilot suggest completions

### Use GitHub Copilot Agents

In Copilot Chat, try these commands:

- `@swift-developer create a new model for a blog post`
- `@code-reviewer review the DataService implementation`

### Build Your First Feature

Let's add a new feature using Copilot:

1. Create a new file: `Sources/MySwiftApp/Calculator.swift`
2. Start typing:
   ```swift
   /// A simple calculator
   struct Calculator {
   ```
3. Let Copilot suggest the implementation
4. Add tests in `Tests/MySwiftAppTests/CalculatorTests.swift`
5. Run tests: `swift test`

## Debugging

### VS Code Debugging

1. Set a breakpoint by clicking in the gutter next to a line number
2. Press `F5` or click the Debug icon
3. Select "Debug Swift App"
4. Step through your code with:
   - `F10` - Step over
   - `F11` - Step into
   - `F12` - Step out

### LLDB Commands

In the Debug Console:
- `po variableName` - Print object
- `p expression` - Evaluate expression
- `bt` - Show backtrace

## Tips for Success

### 🎯 Keep Building

- Start small, iterate quickly
- Let Copilot handle boilerplate
- Focus on architecture and design
- Write tests as you go

### 🤖 Leverage AI

- Use `@swift-developer` for implementation help
- Use `@code-reviewer` for code reviews
- Ask Claude for architecture advice
- Let Copilot complete repetitive code

### 📚 Learn Continuously

- Read the Swift API Design Guidelines
- Explore SwiftUI documentation
- Check out the example code
- Review best practices in the template

## Common Issues

### "Command not found: swift"

**Solution**: Install Xcode Command Line Tools:
```bash
xcode-select --install
```

### VS Code Extensions Not Working

**Solution**: 
1. Restart VS Code
2. Check the Extensions panel for errors
3. Reinstall problematic extensions

### Build Fails

**Solution**:
```bash
swift package clean
swift build
```

### Tests Fail on macOS

**Solution**: Ensure you have Xcode 15.0+ installed with Swift 5.9+

## Getting Help

- 📖 Read the full [README.md](README.md)
- 🤖 Check the [Claude Guide](CLAUDE_GUIDE.md)
- 🐛 Open an issue on GitHub
- 💬 Ask in Copilot Chat

## Ready to Go! 🎉

You're all set! Start building your iOS/macOS app with the power of AI assistance.

**Happy Coding!** 🚀
