//
//  View-ExpenseStyle.swift
//  iExpense
//
//  Created by Francisco Ruiz on 14/12/21.
//

import SwiftUI

extension View {
    func style(for item: ExpenseItem) -> some View {
        if item.amount < 10 {
            return self.font(.body).foregroundColor(.green)
        } else if item.amount < 100 {
            return self.font(.title3).foregroundColor(.primary)
        } else {
            return self.font(.title).foregroundColor(.red)
        }
    }
}
