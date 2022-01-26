//
//  SettingsView.swift
//  RollDice
//
//  Created by Francisco Ruiz on 26/01/22.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var dices: Dices
    
    @State private var howManyDices: Int = 0
    @State private var howManyFaces: Int = 0
    
    let availableFaces = [4, 6, 8, 10, 12, 20, 100]
    let availableDices = [1, 2, 3, 4, 5]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Cuantos Datos?", selection: $howManyDices) {
                        ForEach(availableDices, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    
                    Picker("Cuantas Caras?", selection: $howManyFaces) {
                        ForEach(availableFaces, id: \.self) {
                            Text("\($0)")
                        }
                    }
                }
                
                Section {
                    Button {
                        self.dices.setConfig(numberOfDices: howManyDices, numberOfFaces: howManyFaces)
                        
                        dismiss()
                    } label: {
                        Text("Guardar")
                    }
                }
            }
            .navigationTitle("Configuración")
        }
        .onAppear {
            self.howManyDices = self.dices.howManyDices
            self.howManyFaces = self.dices.howManyFaces
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
