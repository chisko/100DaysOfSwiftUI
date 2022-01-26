//
//  LogView.swift
//  RollDice
//
//  Created by Francisco Ruiz on 26/01/22.
//

import SwiftUI
/*
2,4
43,61,5,69,67
2,7,5,17
6,
5,2
*/
struct LogView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var dices: Dices
    
    var body: some View {
        NavigationView {
            VStack {
                if self.dices.historial.count == 0 {
                    Text("No se han encontrado resultados")
                } else {
                    List {
                        ForEach(self.dices.historial) { item in
                            VStack(alignment: .leading) {
                                Text("\(item.dados.count) dados de \(item.caras) caras")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                
                                Text("\(item.dados.map{ "\($0.number)" }.joined(separator:", "))")
                            }
                        }
                    }
                }
            }
            .navigationTitle("Resultados")
        }
    }
}

struct LogView_Previews: PreviewProvider {
    static var previews: some View {
        LogView()
    }
}
