//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Francisco Ruiz on 20/12/21.
//

import SwiftUI

@main
struct CoreDataProjectApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
