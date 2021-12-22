//
//  FriendfaceApp.swift
//  Friendface
//
//  Created by Francisco Ruiz on 22/12/21.
//

import SwiftUI

@main
struct FriendfaceApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
