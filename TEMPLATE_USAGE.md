# 📦 Using This as a GitHub Template

This guide explains how to use this repository as a template for your own iOS/Mac Swift projects.

## For Template Users

### Creating a New Project from This Template

1. **Click "Use this template"** button at the top of this repository
2. **Choose a name** for your new repository
3. **Select visibility** (public or private)
4. **Click "Create repository from template"**

### After Creating Your Repository

1. **Clone your new repository:**
   ```bash
   git clone https://github.com/YOUR-USERNAME/YOUR-REPO-NAME.git
   cd YOUR-REPO-NAME
   ```

2. **Customize the project:**
   - Update `Package.swift` with your project name
   - Rename directories in `Sources/` and `Tests/`
   - Update all references to `MySwiftApp` in the code
   - Modify `README.md` to describe your project
   - Update `LICENSE` if needed

3. **Install dependencies and test:**
   ```bash
   swift build
   swift test
   ```

4. **Start coding!** 🚀

## For Template Maintainers

### Making This Repository a Template

If you're maintaining a fork or variant of this template:

1. **Go to Settings** in your repository
2. **Check "Template repository"** under the Template section
3. **Save changes**

### Best Practices for Template Repositories

#### 1. Keep It Minimal but Complete

- ✅ Include essential configuration files
- ✅ Provide working example code
- ✅ Add comprehensive documentation
- ❌ Don't include project-specific code
- ❌ Avoid too many dependencies

#### 2. Maintain Clear Documentation

- **README.md** - Overview and quick start
- **QUICKSTART.md** - Step-by-step setup guide
- **EXAMPLES.md** - Code examples and patterns
- **CLAUDE_GUIDE.md** - AI integration guide
- **CONTRIBUTING.md** - Contribution guidelines

#### 3. Use Sensible Defaults

- Include `.gitignore` for Swift/Xcode
- Set up `.editorconfig` for consistent formatting
- Configure VS Code with useful extensions
- Add `.swiftlint.yml` for code quality

#### 4. Provide GitHub Integrations

- **Copilot Agents** in `.github/agents/`
- **CI/CD workflows** in `.github/workflows/`
- **Issue templates** in `.github/ISSUE_TEMPLATE/`
- **PR template** in `.github/PULL_REQUEST_TEMPLATE.md`

#### 5. Include Example Code

- Basic library structure
- CLI executable example
- Comprehensive unit tests
- Common Swift patterns

#### 6. Version Your Template

Consider using git tags for template versions:

```bash
git tag -a v1.0.0 -m "Initial template release"
git push origin v1.0.0
```

Users can then specify which version to use:
```bash
git clone --branch v1.0.0 https://github.com/YOUR-USERNAME/template.git
```

### Updating the Template

When you make improvements:

1. **Test thoroughly** - ensure everything works
2. **Update documentation** - reflect all changes
3. **Commit with clear messages** - describe what changed
4. **Tag releases** - use semantic versioning
5. **Update README** - mention new features
6. **Notify users** - if you have a community

### Template Maintenance Checklist

Regular maintenance tasks:

- [ ] Keep dependencies up to date
- [ ] Update Swift version requirements
- [ ] Review and merge community contributions
- [ ] Update documentation for clarity
- [ ] Test with latest Xcode version
- [ ] Ensure CI/CD workflows pass
- [ ] Update code examples with new patterns
- [ ] Review and update Copilot agents
- [ ] Check for security vulnerabilities
- [ ] Maintain compatibility with latest tools

## Customization Guide

### Renaming the Project

1. **Update Package.swift:**
   ```swift
   let package = Package(
       name: "YourProjectName",  // Change this
       // ...
   )
   ```

2. **Rename directories:**
   ```bash
   mv Sources/MySwiftApp Sources/YourProjectName
   mv Sources/MySwiftAppCLI Sources/YourProjectNameCLI
   mv Tests/MySwiftAppTests Tests/YourProjectNameTests
   ```

3. **Update imports in Swift files:**
   ```swift
   import YourProjectName  // instead of MySwiftApp
   ```

4. **Update VS Code launch.json:**
   ```json
   "program": "${workspaceFolder}/.build/debug/YourProjectName"
   ```

### Adding Dependencies

Edit `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/apple/swift-argument-parser", from: "1.2.0"),
],
targets: [
    .target(
        name: "YourProjectName",
        dependencies: [
            .product(name: "ArgumentParser", package: "swift-argument-parser"),
        ]),
]
```

### Changing Platform Requirements

Update `platforms` in `Package.swift`:

```swift
platforms: [
    .iOS(.v17),      // Latest iOS
    .macOS(.v14),    // Latest macOS
    .watchOS(.v10),  // Add watchOS support
    .tvOS(.v17)      // Add tvOS support
]
```

### Adding SwiftUI Support

1. **Update Package.swift:**
   ```swift
   .target(
       name: "YourProjectName",
       dependencies: [],
       swiftSettings: [
           .enableUpcomingFeature("StrictConcurrency")
       ])
   ```

2. **Create SwiftUI views:**
   ```bash
   mkdir -p Sources/YourProjectName/Views
   ```

3. **Add example view:**
   ```swift
   // Sources/YourProjectName/Views/ContentView.swift
   import SwiftUI
   
   public struct ContentView: View {
       public init() {}
       
       public var body: some View {
           Text("Hello, SwiftUI!")
       }
   }
   ```

### Custom Copilot Agents

Create specialized agents for your project:

```markdown
# .github/agents/domain-expert.md

You are an expert in [your domain].

## Your Role
- Specialized knowledge in [topic]
- Best practices for [area]
- Common patterns for [use case]

## Guidelines
- [Guideline 1]
- [Guideline 2]
```

### CI/CD Customization

Modify `.github/workflows/swift.yml`:

```yaml
- name: Custom Build Step
  run: |
    swift build --configuration release
    ./scripts/your-custom-script.sh

- name: Deploy
  if: github.ref == 'refs/heads/main'
  run: ./scripts/deploy.sh
```

## Template Features Checklist

When creating or evaluating a template, check for:

### Essential Files
- [ ] README.md with clear instructions
- [ ] LICENSE file
- [ ] .gitignore for Swift/Xcode
- [ ] Package.swift or .xcodeproj
- [ ] Example source code
- [ ] Unit tests

### Developer Experience
- [ ] VS Code configuration
- [ ] Recommended extensions
- [ ] Debug configurations
- [ ] Build tasks
- [ ] Code snippets

### Documentation
- [ ] Quick start guide
- [ ] Code examples
- [ ] API documentation
- [ ] Contributing guidelines
- [ ] AI integration guide

### GitHub Integration
- [ ] Copilot agent configurations
- [ ] CI/CD workflows
- [ ] Issue templates
- [ ] PR template
- [ ] Dependabot configuration

### Code Quality
- [ ] Linter configuration
- [ ] Code formatter settings
- [ ] Test coverage setup
- [ ] Pre-commit hooks (optional)

### Modern Features
- [ ] Swift 5.9+ features
- [ ] Async/await examples
- [ ] SwiftUI support (if applicable)
- [ ] Protocol-oriented programming
- [ ] Actor-based concurrency

## Community and Support

### For Template Users

If you have questions:
1. Check the documentation first
2. Search existing issues
3. Open a new issue with details
4. Use Discussions for questions

### For Template Maintainers

Support your users:
1. Respond to issues promptly
2. Welcome contributions
3. Maintain clear documentation
4. Keep the template updated
5. Foster a positive community

## Best Practices Summary

✅ **DO:**
- Keep the template simple and focused
- Provide comprehensive documentation
- Include working example code
- Test thoroughly before releasing
- Use semantic versioning
- Respond to community feedback

❌ **DON'T:**
- Include project-specific code
- Add too many dependencies
- Let documentation become outdated
- Ignore security updates
- Make breaking changes without warning

## Resources

- [GitHub Template Repositories](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-template-repository)
- [Swift Package Manager](https://swift.org/package-manager/)
- [Swift API Design Guidelines](https://swift.org/documentation/api-design-guidelines/)
- [SwiftLint](https://github.com/realm/SwiftLint)
- [GitHub Copilot](https://github.com/features/copilot)

## Feedback

Template improvements? Found an issue? Have suggestions?

- 🐛 [Report a bug](../../issues/new?template=bug_report.md)
- 💡 [Request a feature](../../issues/new?template=feature_request.md)
- 💬 [Start a discussion](../../discussions)

---

Happy templating! 🎉
