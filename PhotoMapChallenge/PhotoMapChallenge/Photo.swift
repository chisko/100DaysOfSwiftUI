//
//  Photo.swift
//  PhotoMapChallenge
//
//  Created by Francisco Ruiz on 04/01/22.
//

import Foundation
import CoreLocation

struct Photo: Identifiable, Codable {
    var id: UUID
    var name: String
    let latitude: Double
    let longitude: Double
    
    var photoUrl: URL {
        FileManager.documentsDirectory.appendingPathComponent("\(id)")
    }
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
