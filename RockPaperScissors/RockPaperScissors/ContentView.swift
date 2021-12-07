//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Francisco Ruiz on 06/12/21.
//

import SwiftUI

struct ContentView: View {
    @State private var moves = ["Rock", "Paper", "Scissors"]
    @State private var currentMove = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    
    @State private var score = 0
    @State private var moveTitle = ""
    
    @State private var showAlert = false
    @State private var showEndGame = false
    @State private var plays = 0
    
    var body: some View {
        VStack {
            Text("Your score is \(score)")
            
            Text("App's Move: \(moves[currentMove])")
            
            if shouldWin {
                Text("You should win")
            } else {
                Text("You should loose")
            }
            
            HStack {
                ForEach(0..<moves.count, id: \.self) { moveIndex in
                    Button {
                        moveTapped(moveIndex)
                    } label: {
                        Text("\(moves[moveIndex])")
                    }
                }
            }
        }
        .alert(moveTitle, isPresented: $showAlert) {
            Button("Continue", action: nextMove)
        } message: {
            Text("Your score is \(score)")
        }
        .alert("You finished the game!", isPresented: $showEndGame) {
            Button("Play again", action: resetGame)
        } message: {
            Text("Your score is \(score)")
        }
    }
    
    func moveTapped(_ moveIndex: Int) {
        plays += 1
        
        // App Rock, Should Win, User Paper; App Rock, Should Loose, User Scissors
        if (currentMove == 0 && shouldWin && moveIndex == 1) || (currentMove == 0 && !shouldWin && moveIndex == 2) {
            score += 1
            moveTitle = "You win!"
        }
        // App Paper, Should Win, User Scissors; App Paper, Should Loose, User Rock
        else if (currentMove == 1 && shouldWin && moveIndex == 2) || (currentMove == 1 && !shouldWin && moveIndex == 0) {
            score += 1
            moveTitle = "You win!"
        }
        // App Scissors, Should Win, User Rock; App Scissors, Should Loose, User Paper
        else if (currentMove == 2 && shouldWin && moveIndex == 0) || (currentMove == 2 && !shouldWin && moveIndex == 1) {
            score += 1
            moveTitle = "You win!"
        } else {
            score -= 1
            moveTitle = "You loose!"
        }
        
        if plays == 10 {
            showEndGame = true
        } else {
            showAlert = true
        }
    }
    
    func nextMove() {
        currentMove = Int.random(in: 0...2)
        shouldWin = Bool.random()
    }
    
    func resetGame() {
        plays = 0
        score = 0
        nextMove()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
