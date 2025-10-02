# 📚 Code Examples

This document provides practical examples of common Swift patterns and how to use them with GitHub Copilot and Claude Sonnet 4.x.

## Table of Contents

1. [Basic Swift Patterns](#basic-swift-patterns)
2. [Async/Await](#asyncawait)
3. [SwiftUI Views](#swiftui-views)
4. [Protocol-Oriented Programming](#protocol-oriented-programming)
5. [Error Handling](#error-handling)
6. [Testing Patterns](#testing-patterns)
7. [Copilot Tips](#copilot-tips)

## Basic Swift Patterns

### Value Types (Struct)

```swift
/// A model representing a book
struct Book: Codable, Equatable, Identifiable {
    let id: UUID
    let title: String
    let author: String
    let publishedYear: Int
    
    var description: String {
        "\(title) by \(author) (\(publishedYear))"
    }
    
    init(id: UUID = UUID(), title: String, author: String, publishedYear: Int) {
        self.id = id
        self.title = title
        self.author = author
        self.publishedYear = publishedYear
    }
}
```

### Enums with Associated Values

```swift
/// API errors that can occur
enum APIError: Error, LocalizedError {
    case networkError(Error)
    case invalidResponse
    case decodingError(Error)
    case unauthorized
    
    var errorDescription: String? {
        switch self {
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        case .invalidResponse:
            return "Invalid response from server"
        case .decodingError(let error):
            return "Failed to decode response: \(error.localizedDescription)"
        case .unauthorized:
            return "Unauthorized access"
        }
    }
}
```

### Extensions

```swift
extension String {
    /// Validates if the string is a valid email
    var isValidEmail: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return predicate.evaluate(with: self)
    }
    
    /// Truncates the string to the specified length
    func truncated(to length: Int, trailing: String = "...") -> String {
        guard self.count > length else { return self }
        return String(self.prefix(length)) + trailing
    }
}
```

## Async/Await

### Network Service

```swift
import Foundation

actor NetworkService {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    /// Fetches data from the given URL
    func fetchData(from url: URL) async throws -> Data {
        let (data, response) = try await session.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw APIError.unauthorized
        }
        
        return data
    }
    
    /// Fetches and decodes JSON data
    func fetch<T: Decodable>(_ type: T.Type, from url: URL) async throws -> T {
        let data = try await fetchData(from: url)
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(type, from: data)
        } catch {
            throw APIError.decodingError(error)
        }
    }
}
```

### Parallel Async Operations

```swift
/// Fetches multiple resources concurrently
func fetchMultipleResources() async throws -> [Book] {
    async let books1 = fetchBooks(from: url1)
    async let books2 = fetchBooks(from: url2)
    async let books3 = fetchBooks(from: url3)
    
    let results = try await [books1, books2, books3]
    return results.flatMap { $0 }
}
```

### Task Groups

```swift
/// Processes items concurrently with a task group
func processItems(_ items: [Item]) async throws -> [Result] {
    try await withThrowingTaskGroup(of: Result.self) { group in
        for item in items {
            group.addTask {
                try await processItem(item)
            }
        }
        
        var results: [Result] = []
        for try await result in group {
            results.append(result)
        }
        return results
    }
}
```

## SwiftUI Views

### Basic View with State

```swift
import SwiftUI

struct CounterView: View {
    @State private var count = 0
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Count: \(count)")
                .font(.largeTitle)
            
            HStack(spacing: 15) {
                Button("-") {
                    count -= 1
                }
                .buttonStyle(.bordered)
                
                Button("+") {
                    count += 1
                }
                .buttonStyle(.bordered)
            }
        }
        .padding()
    }
}
```

### ViewModel Pattern

```swift
import SwiftUI
import Combine

@MainActor
class BooksViewModel: ObservableObject {
    @Published var books: [Book] = []
    @Published var isLoading = false
    @Published var error: Error?
    
    private let service: NetworkService
    
    init(service: NetworkService = NetworkService()) {
        self.service = service
    }
    
    func loadBooks() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            books = try await service.fetch([Book].self, from: booksURL)
            error = nil
        } catch {
            self.error = error
        }
    }
}

struct BooksView: View {
    @StateObject private var viewModel = BooksViewModel()
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView()
                } else if let error = viewModel.error {
                    ContentUnavailableView(
                        "Error",
                        systemImage: "exclamationmark.triangle",
                        description: Text(error.localizedDescription)
                    )
                } else {
                    List(viewModel.books) { book in
                        BookRow(book: book)
                    }
                }
            }
            .navigationTitle("Books")
            .task {
                await viewModel.loadBooks()
            }
        }
    }
}
```

## Protocol-Oriented Programming

### Protocol Definition

```swift
/// Protocol for data persistence
protocol DataPersistence {
    associatedtype Item: Codable
    
    func save(_ item: Item) async throws
    func load(id: UUID) async throws -> Item?
    func delete(id: UUID) async throws
    func loadAll() async throws -> [Item]
}
```

### Protocol Implementation

```swift
actor InMemoryPersistence<T: Codable & Identifiable>: DataPersistence where T.ID == UUID {
    typealias Item = T
    
    private var storage: [UUID: T] = [:]
    
    func save(_ item: T) async throws {
        storage[item.id] = item
    }
    
    func load(id: UUID) async throws -> T? {
        storage[id]
    }
    
    func delete(id: UUID) async throws {
        storage.removeValue(forKey: id)
    }
    
    func loadAll() async throws -> [T] {
        Array(storage.values)
    }
}
```

### Protocol Composition

```swift
protocol Timestamped {
    var createdAt: Date { get }
    var updatedAt: Date { get }
}

protocol Identifiable {
    associatedtype ID: Hashable
    var id: ID { get }
}

// Using multiple protocols
struct Note: Codable, Identifiable, Timestamped {
    let id: UUID
    let content: String
    let createdAt: Date
    var updatedAt: Date
}
```

## Error Handling

### Result Type

```swift
func divide(_ a: Double, by b: Double) -> Result<Double, ArithmeticError> {
    guard b != 0 else {
        return .failure(.divisionByZero)
    }
    return .success(a / b)
}

// Usage
let result = divide(10, by: 2)
switch result {
case .success(let value):
    print("Result: \(value)")
case .failure(let error):
    print("Error: \(error)")
}
```

### Custom Error with Recovery

```swift
enum DatabaseError: Error {
    case connectionFailed
    case queryFailed(String)
    case notFound
    
    var isRetryable: Bool {
        switch self {
        case .connectionFailed:
            return true
        case .queryFailed:
            return false
        case .notFound:
            return false
        }
    }
}

func executeWithRetry<T>(
    maxAttempts: Int = 3,
    operation: () async throws -> T
) async throws -> T {
    var lastError: Error?
    
    for attempt in 1...maxAttempts {
        do {
            return try await operation()
        } catch let error as DatabaseError where error.isRetryable {
            lastError = error
            try await Task.sleep(nanoseconds: UInt64(attempt) * 1_000_000_000)
        } catch {
            throw error
        }
    }
    
    throw lastError ?? DatabaseError.connectionFailed
}
```

## Testing Patterns

### Basic Unit Tests

```swift
import XCTest
@testable import MySwiftApp

final class StringExtensionsTests: XCTestCase {
    func testValidEmail() {
        XCTAssertTrue("test@example.com".isValidEmail)
        XCTAssertFalse("invalid-email".isValidEmail)
        XCTAssertFalse("".isValidEmail)
    }
    
    func testTruncation() {
        let longString = "This is a very long string"
        XCTAssertEqual(longString.truncated(to: 10), "This is a ...")
        XCTAssertEqual("Short".truncated(to: 10), "Short")
    }
}
```

### Async Testing

```swift
final class NetworkServiceTests: XCTestCase {
    var service: NetworkService!
    
    override func setUp() {
        super.setUp()
        service = NetworkService()
    }
    
    override func tearDown() {
        service = nil
        super.tearDown()
    }
    
    func testFetchData() async throws {
        let url = URL(string: "https://api.example.com/data")!
        let data = try await service.fetchData(from: url)
        XCTAssertFalse(data.isEmpty)
    }
    
    func testFetchDecodable() async throws {
        let url = URL(string: "https://api.example.com/books")!
        let books: [Book] = try await service.fetch([Book].self, from: url)
        XCTAssertFalse(books.isEmpty)
    }
}
```

### Mock Objects

```swift
class MockNetworkService: NetworkService {
    var mockData: Data?
    var mockError: Error?
    
    override func fetchData(from url: URL) async throws -> Data {
        if let error = mockError {
            throw error
        }
        return mockData ?? Data()
    }
}

final class BooksViewModelTests: XCTestCase {
    @MainActor
    func testLoadBooks() async {
        let mockService = MockNetworkService()
        let mockBooks = [
            Book(title: "Test Book", author: "Test Author", publishedYear: 2024)
        ]
        mockService.mockData = try? JSONEncoder().encode(mockBooks)
        
        let viewModel = BooksViewModel(service: mockService)
        await viewModel.loadBooks()
        
        XCTAssertEqual(viewModel.books.count, 1)
        XCTAssertNil(viewModel.error)
    }
}
```

## Copilot Tips

### 1. Use Descriptive Comments

```swift
// Create a function that validates a credit card number using the Luhn algorithm
// It should:
// - Accept a string of digits
// - Return true if valid, false otherwise
// - Handle spaces and dashes in the input
```

Then let Copilot generate the implementation.

### 2. Write Test First

```swift
func testEmailValidation() {
    // Test valid emails
    XCTAssertTrue(validator.isValid("user@example.com"))
    XCTAssertTrue(validator.isValid("user.name@example.co.uk"))
    
    // Test invalid emails
    XCTAssertFalse(validator.isValid("invalid"))
    XCTAssertFalse(validator.isValid("@example.com"))
}
```

Then use Copilot to implement the `validator`.

### 3. Pattern Recognition

When you write similar code multiple times, Copilot learns the pattern:

```swift
// First function - write manually
func createUser(_ name: String) async throws -> User {
    let user = User(name: name)
    try await database.save(user)
    return user
}

// Second function - Copilot will suggest based on pattern
func createPost(_ title: String) async throws -> Post {
    // Copilot will suggest: let post = Post(title: title)...
}
```

### 4. Use Natural Language

In Copilot Chat:
- "Create a SwiftUI view for user registration with email and password fields"
- "Add input validation to ensure the password is at least 8 characters"
- "Generate unit tests for the UserViewModel"

### 5. Incremental Development

Start simple, then enhance:

```swift
// Step 1: Basic structure
struct UserProfile {
    let name: String
}

// Step 2: Add Copilot comment: Add email and phone number fields
// Copilot will suggest additions

// Step 3: Add Copilot comment: Make it Codable and add validation
// Copilot will suggest the implementations
```

## Claude Sonnet 4.x Integration

### Ask for Architecture Review

```
I have this code structure:
[paste your code]

Please review the architecture and suggest improvements for:
1. Separation of concerns
2. Testability
3. Maintainability
4. Performance
```

### Request Code Generation

```
Generate a complete implementation of a todo list feature with:
- Todo model (Codable, Identifiable)
- TodoService actor for CRUD operations
- SwiftUI views for list and detail
- Unit tests for all components

Use modern Swift 5.9 features and best practices.
```

### Get Explanations

```
Explain this Swift code and how it uses the actor model for thread safety:
[paste actor code]

What are the benefits and potential pitfalls?
```

## Conclusion

These examples demonstrate common patterns in modern Swift development. Use them as a foundation for your projects and leverage AI assistance to adapt them to your specific needs.

For more information:
- See [README.md](README.md) for template overview
- See [CLAUDE_GUIDE.md](CLAUDE_GUIDE.md) for detailed AI integration
- See [QUICKSTART.md](QUICKSTART.md) for getting started

Happy coding! 🚀
