//
//  CachedFriend+CoreDataProperties.swift
//  Friendface
//
//  Created by Francisco Ruiz on 22/12/21.
//
//

import Foundation
import CoreData


extension CachedFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedFriend> {
        return NSFetchRequest<CachedFriend>(entityName: "CachedFriend")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    
    var wrappedName: String {
        self.name ?? "Unknown Friend"
    }

}

extension CachedFriend : Identifiable {

}
