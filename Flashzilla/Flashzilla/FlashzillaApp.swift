//
//  FlashzillaApp.swift
//  Flashzilla
//
//  Created by Francisco Ruiz on 10/01/22.
//

import SwiftUI

@main
struct FlashzillaApp: App {
    @StateObject var cards = Cards()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(cards)
        }
    }
}
