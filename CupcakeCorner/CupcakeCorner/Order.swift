//
//  Order.swift
//  CupcakeCorner
//
//  Created by Francisco Ruiz on 19/12/21.
//

import SwiftUI

struct Order: Codable {
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
        if name.isReallyEmpty || streetAddress.isReallyEmpty || city.isReallyEmpty || zip.isReallyEmpty {
            return false
        }
        
        return true
    }
    
    var cost: Double {
        // $2 per cake
        var cost = Double(quantity) * 2
        
        // complicated cakes cost more
        cost += (Double(type)) / 2
        
        // $1 per cake for extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }
        
        // $0.50 per cake for sprinkles
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        
        return cost
    }
}

@dynamicMemberLookup
class SharedOrder: ObservableObject {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    @Published var data = Order()
    
    subscript<T>(dynamicMember keyPath: KeyPath<Order, T>) -> T {
        data[keyPath: keyPath]
    }

    subscript<T>(dynamicMember keyPath: WritableKeyPath<Order, T>) -> T {
        get {
            data[keyPath: keyPath]
        }

        set {
            data[keyPath: keyPath] = newValue
        }
    }
}


/*
 * Manually Codable
 *
 class Order: ObservableObject, Codable {
     enum CodingKeys: CodingKey {
         case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, zip
     }
     
     static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
     
     @Published var type = 0
     @Published var quantity = 3
     
     @Published var specialRequestEnabled = false {
         didSet {
             if specialRequestEnabled == false {
                 extraFrosting = false
                 addSprinkles = false
             }
         }
     }
     
     @Published var extraFrosting = false
     @Published var addSprinkles = false
     
     @Published var name = ""
     @Published var streetAddress = ""
     @Published var city = ""
     @Published var zip = ""
     
     var hasValidAddress: Bool {
         if name.isReallyEmpty || streetAddress.isReallyEmpty || city.isReallyEmpty || zip.isReallyEmpty {
             return false
         }
         
         return true
     }
     
     var cost: Double {
         // $2 per cake
         var cost = Double(quantity) * 2
         
         // complicated cakes cost more
         cost += (Double(type)) / 2
         
         // $1 per cake for extra frosting
         if extraFrosting {
             cost += Double(quantity)
         }
         
         // $0.50 per cake for sprinkles
         if addSprinkles {
             cost += Double(quantity) / 2
         }
         
         return cost
     }
     
     init() {}
     
     func encode(to encoder: Encoder) throws {
         var container = encoder.container(keyedBy: CodingKeys.self)
         
         try container.encode(type, forKey: .type)
         try container.encode(quantity, forKey: .quantity)
         
         try container.encode(extraFrosting, forKey: .extraFrosting)
         try container.encode(addSprinkles, forKey: .addSprinkles)
         
         try container.encode(name, forKey: .name)
         try container.encode(streetAddress, forKey: .streetAddress)
         try container.encode(city, forKey: .city)
         try container.encode(zip, forKey: .zip)
     }
     
     required init(from decoder: Decoder) throws {
         let container = try decoder.container(keyedBy: CodingKeys.self)
         
         type = try container.decode(Int.self, forKey: .type)
         quantity = try container.decode(Int.self, forKey: .quantity)
         
         extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
         addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
         
         name = try container.decode(String.self, forKey: .name)
         streetAddress = try container.decode(String.self, forKey: .streetAddress)
         city = try container.decode(String.self, forKey: .city)
         zip = try container.decode(String.self, forKey: .zip)
     }
 }
*/
