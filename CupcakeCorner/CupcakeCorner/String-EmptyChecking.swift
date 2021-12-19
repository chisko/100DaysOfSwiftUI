//
//  String-EmptyChecking.swift
//  CupcakeCorner
//
//  Created by Francisco Ruiz on 19/12/21.
//

import Foundation

extension String {
    var isReallyEmpty: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
