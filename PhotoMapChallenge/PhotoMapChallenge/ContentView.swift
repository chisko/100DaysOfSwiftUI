//
//  ContentView.swift
//  PhotoMapChallenge
//
//  Created by Francisco Ruiz on 04/01/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var photos: [Photo]
    
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    @State private var showingAddNameView = false
    
    let savedDirectory = FileManager.documentsDirectory
    let savedPathPhotoList = FileManager.documentsDirectory.appendingPathComponent("PhotoList")
    
    init() {
        do {
            let data = try Data(contentsOf: savedPathPhotoList)
            let photosData = try JSONDecoder().decode([Photo].self, from: data)
            _photos = State(wrappedValue: photosData)
            print("LOADED DATA")
        } catch {
            _photos = State(wrappedValue: [])
            print("COULDNT LOAD DATA")
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(photos, id: \.id) { photo in
                    NavigationLink {
                        DetailView(photo: photo)
                    } label: {
                        HStack {
                            Image(uiImage: UIImage(contentsOfFile: photo.photoUrl.path) ?? UIImage())
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                            
                            Text(photo.name)
                        }
                    }
                }
                .onDelete(perform: deletePhoto)
            }
            .navigationTitle("PhotoMap")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingImagePicker = true
                    } label: {
                        Label("Add", systemImage: "plus")
                    }
                }
            }
            .onChange(of: inputImage) { _ in loadImage() }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputImage)
            }
            .sheet(isPresented: $showingAddNameView) {
                AddNameView(image: inputImage) { newPhoto in
                    photos.append(newPhoto)
                    saveJson()
                }
            }
        }
    }
    
    func deletePhoto(at offsets: IndexSet) {
        photos.remove(atOffsets: offsets)
        saveJson()
    }
    
    func loadImage() {
        guard inputImage != nil else { return }
        showingAddNameView = true
    }
    
    func saveJson() {
        do {
            let data = try JSONEncoder().encode(photos)
            try data.write(to: savedPathPhotoList, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
