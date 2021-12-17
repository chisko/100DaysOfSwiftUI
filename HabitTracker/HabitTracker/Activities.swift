//
//  Activities.swift
//  HabitTracker
//
//  Created by Francisco Ruiz on 16/12/21.
//

import Foundation

class Activities: ObservableObject {
    @Published var items = [ActivityItem]() {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ActivityItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
}
