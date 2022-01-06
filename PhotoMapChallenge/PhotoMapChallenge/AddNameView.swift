//
//  AddNameView.swift
//  PhotoMapChallenge
//
//  Created by Francisco Ruiz on 04/01/22.
//

import SwiftUI

struct AddNameView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var image: UIImage?
    @State private var name = ""
    
    var onSave: (Photo) -> Void
    
    let locationFetcher = LocationFetcher()
    
    init(image: UIImage?, onSave: @escaping (Photo) -> Void) {
        self.onSave = onSave
        
        _image = State(wrappedValue: image)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Enter Photo Name", text: $name)
                }
                
                if image != nil {
                    Section {
                        Image(uiImage: image!)
                            .resizable()
                            .scaledToFit()
                    }
                }
                
                Section {
                    Button {
                        save()
                        
                        dismiss()
                    } label: {
                        Text("Save")
                    }
                }
                .disabled(name.isEmpty)
            }
            .navigationTitle("Add Photo Name")
        }
        .onAppear {
            self.locationFetcher.start()
        }
    }
    
    func save() {
        guard let image = image else { return }
        
        // generate uuid for image filename
        let uuid = UUID()
        
        // save image to disk
        let savePath = FileManager.documentsDirectory.appendingPathComponent("\(uuid)")
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: savePath, options: [.atomic, .completeFileProtection])
        }
        
        // get users location
        var lat = 0.0
        var lon = 0.0
        if let location = self.locationFetcher.lastKnownLocation {
            print("Your location is \(location)")
            lat = location.latitude
            lon = location.longitude
        }
        
        // new photo
        let newPhoto = Photo(id: uuid, name: name, latitude: lat, longitude: lon)
        onSave(newPhoto)
    }
}
/*
struct AddNameView_Previews: PreviewProvider {
    static var previews: some View {
        AddNameView()
    }
}
*/
