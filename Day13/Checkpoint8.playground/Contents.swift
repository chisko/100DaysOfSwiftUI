import Cocoa

protocol Building {
    var type: String { get }
    var rooms: Int { get }
    var cost: Int { get set }
    var agentName: String { get set }
    func summary()
}

extension Building {
    func summary() {
        print("\(type) with \(rooms) rooms going for \(cost) USD, contact \(agentName)")
    }
}

struct House: Building {
    var type: String
    var rooms: Int
    var cost: Int
    var agentName: String
}

struct Office: Building {
    var type: String
    var rooms: Int
    var cost: Int
    var agentName: String
}

let house = House(type: "House", rooms: 3, cost: 150_000, agentName: "Francisco")
house.summary()
let office = Office(type: "Office", rooms: 12, cost: 450_000, agentName: "Jeanette")
office.summary()
