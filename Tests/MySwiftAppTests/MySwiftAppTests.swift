import XCTest
@testable import MySwiftApp

final class GreetingServiceTests: XCTestCase {
    
    func testDefaultGreeting() {
        let service = GreetingService()
        XCTAssertEqual(service.greet(), "Hello, World!")
    }
    
    func testCustomNameGreeting() {
        let service = GreetingService(name: "Alice")
        XCTAssertEqual(service.greet(), "Hello, Alice!")
    }
    
    func testGreetingWithPrefix() {
        let service = GreetingService(name: "Bob")
        XCTAssertEqual(service.greet(with: "Hi"), "Hi, Bob!")
    }
}

final class PersonTests: XCTestCase {
    
    func testPersonCreation() {
        let person = Person(firstName: "John", lastName: "Doe")
        XCTAssertEqual(person.firstName, "John")
        XCTAssertEqual(person.lastName, "Doe")
        XCTAssertEqual(person.fullName, "John Doe")
    }
    
    func testPersonEquality() {
        let id = UUID()
        let person1 = Person(id: id, firstName: "John", lastName: "Doe")
        let person2 = Person(id: id, firstName: "John", lastName: "Doe")
        XCTAssertEqual(person1, person2)
    }
    
    func testPersonCodable() throws {
        let person = Person(firstName: "Jane", lastName: "Smith")
        let encoder = JSONEncoder()
        let data = try encoder.encode(person)
        
        let decoder = JSONDecoder()
        let decodedPerson = try decoder.decode(Person.self, from: data)
        
        XCTAssertEqual(person, decodedPerson)
    }
}

final class DataServiceTests: XCTestCase {
    
    func testSaveAndFetchPerson() async {
        let service = DataService()
        let person = Person(firstName: "Test", lastName: "User")
        
        await service.savePerson(person)
        let fetched = await service.fetchPerson(by: person.id)
        
        XCTAssertEqual(fetched, person)
    }
    
    func testFetchNonExistentPerson() async {
        let service = DataService()
        let fetched = await service.fetchPerson(by: UUID())
        
        XCTAssertNil(fetched)
    }
    
    func testAllPersons() async {
        let service = DataService()
        let person1 = Person(firstName: "Alice", lastName: "Wonder")
        let person2 = Person(firstName: "Bob", lastName: "Builder")
        
        await service.savePerson(person1)
        await service.savePerson(person2)
        
        let allPersons = await service.allPersons()
        XCTAssertEqual(allPersons.count, 2)
    }
}
