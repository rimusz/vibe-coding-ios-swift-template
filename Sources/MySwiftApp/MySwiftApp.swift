import Foundation

/// A simple greeting service that demonstrates Swift best practices
public struct GreetingService {
    
    /// The name to greet
    private let name: String
    
    /// Initializes a new greeting service
    /// - Parameter name: The name to use in greetings
    public init(name: String = "World") {
        self.name = name
    }
    
    /// Generates a greeting message
    /// - Returns: A personalized greeting string
    public func greet() -> String {
        return "Hello, \(name)!"
    }
    
    /// Generates a greeting message with a custom prefix
    /// - Parameter prefix: The prefix to use before the name
    /// - Returns: A personalized greeting string with the custom prefix
    public func greet(with prefix: String) -> String {
        return "\(prefix), \(name)!"
    }
}

/// A model representing a person
public struct Person: Codable, Equatable {
    public let id: UUID
    public let firstName: String
    public let lastName: String
    
    public var fullName: String {
        "\(firstName) \(lastName)"
    }
    
    public init(id: UUID = UUID(), firstName: String, lastName: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
    }
}

/// An example service that demonstrates async/await
public actor DataService {
    
    private var cache: [UUID: Person] = [:]
    
    public init() {}
    
    /// Fetches a person by ID
    /// - Parameter id: The unique identifier of the person
    /// - Returns: The person if found, nil otherwise
    public func fetchPerson(by id: UUID) async -> Person? {
        // Simulate network delay
        try? await Task.sleep(nanoseconds: 100_000_000) // 0.1 seconds
        return cache[id]
    }
    
    /// Saves a person to the cache
    /// - Parameter person: The person to save
    public func savePerson(_ person: Person) async {
        cache[person.id] = person
    }
    
    /// Retrieves all persons from the cache
    /// - Returns: An array of all cached persons
    public func allPersons() async -> [Person] {
        Array(cache.values)
    }
}
