//
//  FileManager-DocumentsDirectory.swift
//  PhotoMapChallenge
//
//  Created by Francisco Ruiz on 04/01/22.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
