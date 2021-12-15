//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Francisco Ruiz on 10/12/21.
//

import Foundation

struct ExpenseItem: Identifiable, Codable, Equatable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
