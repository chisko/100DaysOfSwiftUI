//
//  DetailView.swift
//  PhotoMapChallenge
//
//  Created by Francisco Ruiz on 04/01/22.
//

import MapKit
import SwiftUI

struct DetailView: View {
    
    let photo: Photo
    
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
    
    var body: some View {
        VStack {
            Image(uiImage: UIImage(contentsOfFile: photo.photoUrl.path) ?? UIImage())
                .resizable()
                .scaledToFit()
            
            HStack {
                Text(photo.name)
                    .font(.title)
                
                Spacer()
            }
            .padding()
            
            Map(coordinateRegion: $mapRegion, annotationItems: [photo]) { location in
                MapAnnotation(coordinate: location.coordinate) {
                    VStack {
                        Image(systemName: "mappin.circle.fill")
                            .resizable()
                            .foregroundColor(.pink)
                            .frame(width: 44, height: 44)
                            
                        
                    }
                }
            }
            
            Spacer()
        }
        .navigationTitle(photo.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

/*
struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
*/
