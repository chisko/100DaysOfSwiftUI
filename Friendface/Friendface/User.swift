//
//  User.swift
//  Friendface
//
//  Created by Francisco Ruiz on 22/12/21.
//

import Foundation

struct User: Codable, Identifiable {
    let id: UUID
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: Date
    let tags: [String]
    let friends: [Friend]
    
    static let example = User(id: UUID(), isActive: true, name: "Francisco Ruiz", age: 34, company: "Dicex", email: "fcoruiz23@gmail.com", address: "12345 Central, Santiago, Nuevo Leon", about: "I like soccer, fan of Real Madrid and love SwiftUI", registered: Date.now, tags: ["SwiftUI", "Real Madrid", "Soccer"], friends: [])
}
/*
class Users: ObservableObject {
    @Published var items = [User]()
}
*/
