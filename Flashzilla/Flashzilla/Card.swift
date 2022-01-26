//
//  Card.swift
//  Flashzilla
//
//  Created by Francisco Ruiz on 10/01/22.
//

import Foundation

struct Card: Identifiable, Codable, Equatable {
    var id = UUID()
    let prompt: String
    let answer: String
    
    static let example = Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.id == rhs.id
    }
}

@MainActor class Cards: ObservableObject {
    @Published private(set) var cards: [Card]
    
    let savePath = FileManager.documentsDirectory.appendingPathComponent("savedQuestions")
    
    init() {
        cards = []
        loadData()
    }
    
    func loadData() {
        do {
            let data = try Data(contentsOf: savePath)
            cards = try JSONDecoder().decode([Card].self, from: data)
        } catch {
            cards = []
        }
    }
    
    func add(_ card: Card) {
        cards.append(card)
        save()
    }
    
    func deleteCards(at offsets: IndexSet) {
        cards.remove(atOffsets: offsets)
        save()
    }
    
    func remove(_ card: Card, error: Bool) {
        guard let index = cards.firstIndex(of: card) else { return }
        
        if error {
            cards.move(fromOffsets: IndexSet(integer: index), toOffset: 0)
        } else {
            cards.remove(at: index)
        }
        save()
    }
    
    private func save() {
        do {
            let data = try JSONEncoder().encode(cards)
            try data.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
}
