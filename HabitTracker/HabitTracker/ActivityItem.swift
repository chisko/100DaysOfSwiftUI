//
//  ActivityItem.swift
//  HabitTracker
//
//  Created by Francisco Ruiz on 16/12/21.
//

import Foundation

struct ActivityItem: Identifiable, Codable, Equatable {
    var id = UUID()
    let name: String
    let description: String
    var completionCount: Int
}
