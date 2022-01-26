//
//  Dice.swift
//  RollDice
//
//  Created by Francisco Ruiz on 26/01/22.
//

import Foundation

struct Dice: Identifiable, Codable {
    var id = UUID()
    var number: Int
}

struct Tiradas: Identifiable, Codable {
    var id = UUID()
    var caras: Int
    var dados: [Dice]
}

@MainActor class Dices: ObservableObject {
    @Published private(set) var dices: [Dice]
    @Published private(set) var historial: [Tiradas]
    
    @Published private(set) var howManyDices: Int
    @Published private(set) var howManyFaces: Int
    
    let savePath = FileManager.documentsDirectory.appendingPathComponent("historial")
    let savePathConfig = FileManager.documentsDirectory.appendingPathComponent("config")
    
    init() {
        dices = []
        historial = []
        howManyDices = 2
        howManyFaces = 6
        
        loadConfig()
        loadHistory()
    }
    
    func rollDice() {
        self.dices.removeAll()
        (0 ..< howManyDices).forEach { _ in
            let dice = Dice(number: Int.random(in: 1 ... howManyFaces))
            self.dices.append(dice)
        }
    }
    
    func addResult() {
        let result = Tiradas(caras: self.howManyFaces, dados: self.dices)
        //self.historial.append(result)
        self.historial.insert(result, at: 0)
        
        self.saveHistory()
    }
    
    private func loadConfig() {
        do {
            let data = try Data(contentsOf: savePathConfig)
            let dataString = try JSONDecoder().decode(String.self, from: data)
            howManyDices = Int(dataString.split(separator: ",")[0]) ?? 2
            howManyFaces = Int(dataString.split(separator: ",")[1]) ?? 6
        } catch {
            howManyDices = 2
            howManyFaces = 6
        }
    }
    
    func setConfig(numberOfDices: Int, numberOfFaces: Int) {
        self.howManyDices = numberOfDices
        self.howManyFaces = numberOfFaces
        
        self.saveConfig()
    }
    
    private func saveConfig() {
        do {
            let data = try JSONEncoder().encode("\(howManyDices),\(howManyFaces)")
            try data.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save config data.")
        }
    }
    
    func loadHistory() {
        do {
            let data = try Data(contentsOf: savePath)
            historial = try JSONDecoder().decode([Tiradas].self, from: data)
        } catch {
            historial = []
        }
        print("HISTORY: \(self.historial.count)")
    }
    
    private func saveHistory() {
        do {
            let data = try JSONEncoder().encode(historial)
            try data.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
            print("SAVED HISTORY: \(savePath)")
        } catch {
            print("Unable to save historic data.")
        }
    }
}
