//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Francisco Ruiz on 20/12/21.
//

import CoreData
import SwiftUI

enum FilterType: String {
    case beginsWith = "BEGINSWITH"
    case contains = "CONTAINS[c]"
}

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(
        sortDescriptors: [],
        predicate: NSPredicate(format: "NOT name BEGINSWITH[c] %@", "e")
            //NSPredicate(format: "name BEGINSWITH[c] %@", "e")
            //NSPredicate(format: "name BEGINSWITH %@", "E")
            //NSPredicate(format: "universe IN %@", ["Star Wars", "Star Trek"])
            //NSPredicate(format: "universe == %@", "Star Wars")
            //NSPredicate(format: "universe == 'Star Wars'")
    ) var ships: FetchedResults<Ship>
    
    @State private var sortDescriptors = [SortDescriptor<Ship>]()
    @State private var filterType = FilterType.beginsWith
    
    @State private var nameFilter = "E"
    @State private var universeFilter = ""
    
    var body: some View {
        NavigationView {
            VStack {
                /*
                List(ships, id: \.self) { ship in
                    Text(ship.name ?? "Unknown name")
                }
                */
                FilteredList(type: filterType, filterKey: "name", filterValue: nameFilter, sortDescriptors: sortDescriptors) { (ship: Ship) in
                    VStack(alignment: .leading) {
                        Text(ship.wrappedName)
                            .font(.headline)
                        
                        Text(ship.wrappedUniverse)
                            .font(.caption)
                    }
                }
                
                if ships.count == 0 {
                    Button("Add Examples") {
                        let ship1 = Ship(context: moc)
                        ship1.name = "Enterprise"
                        ship1.universe = "Star Trek"
                        
                        let ship2 = Ship(context: moc)
                        ship2.name = "Defiant"
                        ship2.universe = "Star Trek"
                        
                        let ship3 = Ship(context: moc)
                        ship3.name = "Millennium Falcon"
                        ship3.universe = "Star Wars"
                        
                        let ship4 = Ship(context: moc)
                        ship4.name = "Executor"
                        ship4.universe = "Star Wars"
                        
                        try? moc.save()
                    }
                }
            }
            .navigationTitle("Ships")
            .toolbar {
                HStack {
                    Menu {
                        Button("Begins with", action:{ filterType = .beginsWith })
                        Button("Contains", action: {filterType = .contains })
                    } label: {
                        Label("Filter", systemImage: "line.3.horizontal.decrease.circle")
                    }
                    
                    Menu {
                        Button("Name", action:{ sortDescriptors = [SortDescriptor(\.name)] })
                        Button("Universe", action: { sortDescriptors = [SortDescriptor(\.universe)] })
                    } label: {
                        Label("Sort", systemImage: "arrow.up.arrow.down")
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
