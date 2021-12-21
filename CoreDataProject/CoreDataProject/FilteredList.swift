//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Francisco Ruiz on 21/12/21.
//

import CoreData
import SwiftUI

struct FilteredList<T: NSManagedObject, Content: View>: View {
    @FetchRequest var fetchRequest: FetchedResults<T>
    let content: (T) -> Content
    
    var body: some View {
        List(fetchRequest, id: \.self) { T in
            self.content(T)
        }
        /*
        List(fetchRequest, id: \.self) { ship in
            VStack(alignment: .leading) {
                Text(ship.wrappedName)
                    .font(.headline)
                
                Text(ship.wrappedUniverse)
                    .font(.caption)
            }
        }
        */
    }
    
    init(type: FilterType = .contains, filterKey: String, filterValue: String, sortDescriptors: [SortDescriptor<T>] = [], @ViewBuilder content: @escaping (T) -> Content) {
        _fetchRequest = FetchRequest<T>(
            sortDescriptors: sortDescriptors,
            predicate: NSPredicate(format: "%K \(type.rawValue) %@", filterKey, filterValue)
        )
        self.content = content
    }
}

