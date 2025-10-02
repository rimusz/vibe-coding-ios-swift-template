# Using Claude Sonnet 4.x for Swift Development

This guide helps you get the most out of Claude Sonnet 4.x when working with this Swift template.

## Overview

Claude Sonnet 4.x is an advanced AI assistant that can help with:

- Code generation and refactoring
- Architecture and design decisions
- Code review and optimization
- Test generation
- Documentation writing
- Debugging assistance

## Best Practices

### 1. Provide Context

Always share relevant context with Claude:

```
I'm working on a Swift iOS app using Swift 5.9 and SwiftUI.
Here's the current code:

[paste your code]

I want to add a feature that...
```

### 2. Be Specific

The more specific your request, the better the result:

❌ "Make this code better"
✅ "Refactor this code to use async/await instead of completion handlers"

❌ "Add error handling"
✅ "Add proper error handling with Swift Result type and custom error enum"

### 3. Request Explanations

Ask Claude to explain the reasoning behind suggestions:

```
Can you refactor this to use protocol-oriented programming?
Please explain why this approach is better.
```

### 4. Iterative Development

Work iteratively with Claude:

1. Start with the basic structure
2. Refine and optimize
3. Add error handling
4. Improve tests
5. Enhance documentation

### 5. Code Review

Use Claude for code reviews:

```
Review this Swift code for:
- Memory leaks and retain cycles
- Performance issues
- Best practices compliance
- Edge cases not handled
```

## Example Workflows

### Feature Development

```
I need to create a user profile feature with:
- UserProfile model (Codable, Equatable)
- ProfileService actor for data management
- SwiftUI view for displaying the profile
- Unit tests

Please generate the code following Swift best practices.
```

### Refactoring

```
Here's my current implementation using completion handlers:
[paste code]

Can you refactor it to use async/await?
Keep the same functionality but make it more modern.
```

### Testing

```
Here's my implementation:
[paste code]

Generate comprehensive XCTest unit tests covering:
- Happy path scenarios
- Edge cases
- Error conditions
- Async operations
```

### Architecture Review

```
I'm building a feature with these requirements:
[describe requirements]

Suggest an architecture using:
- MVVM pattern
- Protocol-oriented programming
- Dependency injection
- Proper separation of concerns
```

## Prompt Templates

### Code Generation

```
Generate a Swift [component type] that:
1. [Requirement 1]
2. [Requirement 2]
3. [Requirement 3]

Requirements:
- Use Swift 5.9+ features
- Follow Swift API Design Guidelines
- Include inline documentation
- Make it testable
- Support iOS 16+ / macOS 13+
```

### Code Review

```
Review this Swift code:
[paste code]

Check for:
1. Code quality and readability
2. Swift best practices
3. Memory management issues
4. Performance concerns
5. Security considerations
6. Missing error handling
7. Testing gaps
```

### Optimization

```
This code works but has performance issues:
[paste code]

Optimize it for:
- Better time complexity
- Reduced memory usage
- Efficient data structures
- Proper async/await usage
```

### SwiftUI Development

```
Create a SwiftUI view that:
- [UI requirement 1]
- [UI requirement 2]
- [UI requirement 3]

Use:
- Modern SwiftUI APIs
- View modifiers appropriately
- Proper state management
- Accessibility support
```

## Tips for Better Results

### 1. Share Project Structure

Help Claude understand your project:

```
My project structure:
- Models/ - Data models
- Services/ - Business logic
- Views/ - SwiftUI views
- ViewModels/ - View models
- Utilities/ - Helper functions

I need to add [feature] in the appropriate location.
```

### 2. Specify Constraints

Be clear about limitations:

```
I need a solution that:
- Supports iOS 16+ (no iOS 17 features)
- Doesn't use external dependencies
- Works offline
- Has minimal memory footprint
```

### 3. Request Alternatives

Ask for multiple approaches:

```
Show me three different ways to implement [feature]:
1. Using protocol-oriented programming
2. Using class inheritance
3. Using value types and composition

Explain pros and cons of each.
```

### 4. Incremental Improvements

Build features step by step:

```
Let's build this feature incrementally:

Step 1: Create the data model
Step 2: Add the service layer
Step 3: Implement the view
Step 4: Add tests
Step 5: Add error handling

Let's start with Step 1.
```

## Common Use Cases

### 1. Model Creation

```
Create a Swift model for a task with:
- id: UUID
- title: String
- description: String?
- dueDate: Date
- isCompleted: Bool

Make it Codable, Equatable, and Hashable.
Add convenience initializers and computed properties.
```

### 2. Service Implementation

```
Create an actor-based service for managing tasks:
- CRUD operations
- Async/await APIs
- Thread-safe
- In-memory storage
Include error handling and validation.
```

### 3. SwiftUI View

```
Create a SwiftUI view for displaying a task list:
- List of tasks
- Pull to refresh
- Swipe to delete
- Add button
- Search functionality
Use MVVM pattern with ObservableObject.
```

### 4. Testing

```
Generate XCTest tests for this service:
[paste service code]

Include tests for:
- All public methods
- Edge cases (empty data, nil values)
- Error scenarios
- Concurrent access (for actors)
```

## Integration with GitHub Copilot

Use Claude and Copilot together:

1. **Claude**: Architecture, design decisions, complex refactoring
2. **Copilot**: Code completion, simple implementations, boilerplate

Example workflow:
1. Ask Claude for architecture design
2. Use Copilot to implement the structure
3. Ask Claude to review the implementation
4. Use Copilot for test boilerplate
5. Ask Claude to enhance test coverage

## Debugging with Claude

When stuck on a bug:

```
I have a bug in this code:
[paste code]

Error message:
[paste error]

What I've tried:
- [attempt 1]
- [attempt 2]

What could be causing this and how to fix it?
```

## Performance Analysis

```
This code is running slowly:
[paste code]

Profile results show:
[paste profiling data]

How can I optimize this?
```

## Conclusion

Claude Sonnet 4.x is a powerful tool for Swift development. Use it strategically:

- For complex problems requiring reasoning
- When you need explanations and learning
- For comprehensive code reviews
- When designing architecture

Combined with GitHub Copilot for code completion and this template's best practices, you have a powerful development environment for building iOS and macOS applications.

Happy coding! 🚀
