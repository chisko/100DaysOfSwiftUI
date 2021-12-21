//
//  Ship+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Francisco Ruiz on 21/12/21.
//
//

import Foundation
import CoreData


extension Ship {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ship> {
        return NSFetchRequest<Ship>(entityName: "Ship")
    }

    @NSManaged public var name: String?
    @NSManaged public var universe: String?

    var wrappedName: String {
        name ?? "Unknown"
    }
    
    var wrappedUniverse: String {
        universe ?? "Unknown"
    }
}

extension Ship : Identifiable {

}
