//
//  FormatStyle-LocalCurrency.swift
//  iExpense
//
//  Created by Francisco Ruiz on 14/12/21.
//

import Foundation

extension FormatStyle where Self == FloatingPointFormatStyle<Double>.Currency {
    static var localCurrency: Self {
        .currency(code: Locale.current.currencyCode ?? "USD")
    }
}
