//
//  EditCardsView.swift
//  Flashzilla
//
//  Created by Francisco Ruiz on 12/01/22.
//

import SwiftUI

struct EditCardsView: View {
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var cards: Cards
    //@State private var cards: [Card] = []
    
    @State private var prompt: String = ""
    @State private var answer: String = ""
    
    //let savedKey = "savedCards"
    //let savePath = FileManager.documentsDirectory.appendingPathComponent("savedQuestions")
    func loadData() {
        cards.loadData()
    }
    /*
    func loadData() {
        /*
        if let data = UserDefaults.standard.data(forKey: savedKey) {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                cards = decoded
                print("Loaded")
            }
        }
        */
        do {
            let data = try Data(contentsOf: savePath)
            cards = try JSONDecoder().decode([Card].self, from: data)
        } catch {
            cards = []
        }
    }
    
    func save() {
        /*
        if let encoded = try? JSONEncoder().encode(cards) {
            UserDefaults.standard.set(encoded, forKey: savedKey)
            print("Saved")
        }
        */
        do {
            let data = try JSONEncoder().encode(cards)
            try data.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unabel to save data.")
        }
    }
    */
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Prompt", text: $prompt)
                    
                    TextField("Answer", text: $answer)
                    
                    Button {
                        let newCard = Card(prompt: prompt, answer: answer)
                        //cards.insert(newCard, at: 0)
                        cards.add(newCard)
                        
                        //save()
                        
                        prompt = ""
                        answer = ""
                    } label: {
                        Text("Add")
                    }
                    .disabled(prompt.isEmpty || answer.isEmpty)
                }
                
                Section {
                    ForEach(cards.cards) { card in
                        VStack(alignment: .leading) {
                            Text(card.prompt)
                                .font(.headline)
                            
                            Text(card.answer)
                                .foregroundColor(.secondary)
                        }
                    }
                    .onDelete(perform: deleteCards)
                }
            }
            .listStyle(.grouped)
            .navigationTitle("Edit Cards")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Done")
                    }
                }
            }
            .onAppear(perform: loadData)
        }
    }
    /*
    func deleteCards(at offsets: IndexSet) {
        cards.remove(atOffsets: offsets)
        save()
    }
    */
    func deleteCards(at offsets: IndexSet) {
        cards.deleteCards(at: offsets)
    }
}
/*
struct EditCardsView_Previews: PreviewProvider {
    static var previews: some View {
        EditCardsView()
    }
}
*/
