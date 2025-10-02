import Foundation
import MySwiftApp

// Simple CLI demonstrating the library usage

print("=== MySwiftApp Demo ===\n")

// Demonstrate GreetingService
let defaultGreeting = GreetingService()
print(defaultGreeting.greet())

let personalGreeting = GreetingService(name: "Swift Developer")
print(personalGreeting.greet())
print(personalGreeting.greet(with: "Welcome"))

print("\n=== Person Model Demo ===\n")

// Demonstrate Person model
let person1 = Person(firstName: "John", lastName: "Doe")
let person2 = Person(firstName: "Jane", lastName: "Smith")

print("Person 1: \(person1.fullName) (ID: \(person1.id))")
print("Person 2: \(person2.fullName) (ID: \(person2.id))")

// Demonstrate async/await with DataService
print("\n=== DataService Demo ===\n")

Task {
    let service = DataService()
    
    // Save persons
    await service.savePerson(person1)
    await service.savePerson(person2)
    
    // Fetch person
    if let fetched = await service.fetchPerson(by: person1.id) {
        print("Fetched: \(fetched.fullName)")
    }
    
    // Get all persons
    let allPersons = await service.allPersons()
    print("Total persons in cache: \(allPersons.count)")
    
    for person in allPersons {
        print("  - \(person.fullName)")
    }
    
    exit(0)
}

// Keep the program running for async operations
dispatchMain()
