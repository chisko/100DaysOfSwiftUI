//
//  Friend.swift
//  Friendface
//
//  Created by Francisco Ruiz on 22/12/21.
//

import Foundation

struct Friend: Codable, Identifiable {
    let id: UUID
    let name: String
}
