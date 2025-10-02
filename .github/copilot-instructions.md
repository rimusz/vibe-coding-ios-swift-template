# GitHub Copilot Instructions for Swift Development

This project follows Swift best practices and Apple's guidelines. Use these instructions when assisting with code development and reviews.

## Development Guidelines

### Code Quality Standards
- Write clear, maintainable Swift code following Swift API Design Guidelines
- Use descriptive naming that clearly communicates intent
- Keep functions focused and single-purpose
- Avoid code duplication through proper abstraction
- Add comments only to explain "why" not "what"
- Apply appropriate access control levels (private, fileprivate, internal, public)

### Swift Best Practices
- Use optionals correctly and safely unwrap them (guard let, if let)
- Leverage Swift's type system for compile-time safety
- Prefer value types (struct, enum) over reference types (class) when appropriate
- Apply protocol-oriented programming patterns
- Use functional programming concepts (map, filter, reduce, compactMap)
- Use guard statements for early exits and validation
- Prefer immutability (let over var) whenever possible
- Handle errors comprehensively using throws, Result, or Optional

### iOS/macOS Development
- Use SwiftUI for modern UI development
- Understand UIKit for legacy code maintenance
- Follow the Model-View-ViewModel (MVVM) pattern
- Handle asynchronous operations with async/await
- Use Combine for reactive programming when appropriate
- Manage app lifecycle properly

### Memory Management
- Avoid retain cycles in closures (use [weak self] or [unowned self])
- Use weak/unowned references correctly
- Properly manage object lifecycles
- Be mindful of reference counting

### Performance Considerations
- Profile code before optimizing
- Use lazy properties for expensive computations
- Leverage Grand Central Dispatch (GCD) for concurrency
- Choose efficient algorithms and data structures
- Use lazy evaluation where appropriate
- Handle asynchronous operations efficiently

### Testing Requirements
- Write unit tests using XCTest for new functionality
- Apply test-driven development (TDD) when appropriate
- Test edge cases and error conditions
- Mock dependencies for isolated testing
- Keep tests maintainable, clear, and focused
- Ensure tests are deterministic and repeatable

### Security Practices
- Never hardcode secrets, API keys, or sensitive data
- Validate and sanitize all user inputs
- Use HTTPS for all network communication
- Handle authentication and authorization properly
- Follow security best practices for data storage

## Code Review Standards

When reviewing code changes, check for:

### Quality Checks
- Adherence to Swift API Design Guidelines
- Clear and descriptive naming conventions
- Single-purpose, focused functions
- Absence of code duplication
- Appropriate commenting

### Swift-Specific Checks
- Proper optional handling and safe unwrapping
- Correct access control usage
- Appropriate use of value vs reference types
- Correct protocol-oriented programming implementation
- Comprehensive error handling

### Performance Reviews
- No obvious performance bottlenecks
- Efficient algorithms and data structures
- Proper use of lazy evaluation
- Correct asynchronous operation handling

### Memory Management Reviews
- Check for potential retain cycles (especially in closures)
- Verify correct weak/unowned reference usage
- Validate proper lifecycle management

### Test Coverage
- New functionality has corresponding unit tests
- Edge cases are tested
- Tests are maintainable and clear
- Test coverage is adequate

### Security Reviews
- No hardcoded secrets or sensitive data
- Proper input validation
- Secure communication protocols
- Safe data handling practices

## Communication Expectations

When providing assistance:
- Be concise and clear in explanations
- Provide complete, runnable code examples
- Explain the reasoning behind design decisions
- Suggest alternatives when appropriate
- Be constructive and supportive in feedback
- Acknowledge good practices in existing code
- Prioritize critical issues over style preferences

## Tools & Technologies

This project uses:
- Swift 5.9+
- SwiftUI and UIKit
- XcodeGen for project file generation
- xcrun for command-line tool invocation
- xcodebuild for building and testing
- Xcode and VS Code
- LLDB debugger
- XCTest framework
- SourceKit-LSP for language server support

## Project Structure

Follow these conventions:
- Use XcodeGen to manage project structure via `project.yml`
- Generate `.xcodeproj` files using `xcodegen` command
- Build with `xcodebuild` instead of `swift build`
- Run tests with `xcodebuild test` instead of `swift test`
- Use `xcrun` to invoke Swift and other development tools
- Follow the existing project structure and organization
