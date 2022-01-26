//
//  RollDiceApp.swift
//  RollDice
//
//  Created by Francisco Ruiz on 26/01/22.
//

import SwiftUI

@main
struct RollDiceApp: App {
    @StateObject var dices = Dices()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(dices)
        }
    }
}
